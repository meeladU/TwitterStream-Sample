//
//  TweetListInteractor.swift
//  TwitterStream-Sample
//

import Foundation

protocol TweetListInteractorInput: AnyObject {
    func searchTweet(with keyword: String)
}

final class TweetListInteractor {
    private let presenter: TweetListPresenterInput
    private let service: TwitterServiceProtocol

    private var searchKeyword = ""

    init(presenter: TweetListPresenterInput, service: TwitterServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }

    private func fetchFeeds() {
        service.fetchFeeds({ [weak self] result in
            switch result {
            case .newData(let tweets):
                self?.presenter.didRetrieveFeeds(tweets)
            case .failure(let error):
                self?.presenter.didRetriveFeedsFailed(with: error)
            case .needToReconnect:
                self?.presenter.tryingReconnect()
                DispatchQueue.main.sync {
                    self?.retryStreaming()
                }
            }
        })
    }

    private func handleGetRulesResponse(_ result: Result<TweetRuleResponseModel, TSError>) {
        switch result {
        case .success(let ruleResponse):
            let rules = ruleResponse.rules
            if !rules.isEmpty {
                let rulesIds = rules.compactMap { $0.id }
                service.deleteRules(with: rulesIds) { [weak self] result in
                    guard let strongSelf = self else {
                        return
                    }
                    strongSelf.handleDeleteRulesResponse(result)
                }
            } else {
                service.addRule(with: searchKeyword) { [weak self] result in
                    guard let strongSelf = self else {
                        return
                    }
                    strongSelf.handleAddRulesResponse(result)
                }
            }
        case .failure(let error):
            presenter.didSetRuleFailed(with: .custom(string: "Error in get rule: \(error.localizedDescription)"))
        }
    }

    private func handleDeleteRulesResponse(_ result: Result<TweetDeleteRuleResponseModel, TSError>) {
        switch result {
        case .success(_):
            service.addRule(with: searchKeyword) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.handleAddRulesResponse(result)
            }

        case .failure(let error):
            presenter.didSetRuleFailed(with: error)
        }
    }

    private func handleAddRulesResponse(_ result: (Result<TweetRuleResponseModel, TSError>)) {
        switch result {
        case .success(_):
            fetchFeeds()

        case .failure(let error):
            presenter.didSetRuleFailed(with: error)
        }
    }
    
    private func retryStreaming() {
        fetchFeeds()
    }
}

extension TweetListInteractor: TweetListInteractorInput {
    func searchTweet(with keyword: String) {
        searchKeyword = keyword
        service.getRules { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            strongSelf.handleGetRulesResponse(result)
        }
    }
}
