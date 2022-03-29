//
//  TwitterService.swift
//  TwitterStream-Sample
//

import Foundation

typealias FetchFeedsCompletionClosure = (TwitterService.TaskResult) -> Void

protocol TwitterServiceProtocol {
    func getRules(_ completion: @escaping (Result<TweetRuleResponseModel, TSError>) -> Void)
    func addRule(with keyword: String, completion: @escaping (Result<TweetRuleResponseModel, TSError>) -> Void)
    func deleteRules(
        with ruleIds: [String],
        completion: @escaping (Result<TweetDeleteRuleResponseModel, TSError>) -> Void
    )
    func fetchFeeds(_ completion: @escaping FetchFeedsCompletionClosure)
}

final class TwitterService: RequestHandler {
    var task: URLSessionTask?

    enum TaskResult {
        case newData([FeedResponseModel])
        case failure(TSError)
        case needToReconnect
    }
    private func cancelTask() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}

extension TwitterService: TwitterServiceProtocol {
    func getRules(_ completion: @escaping (Result<TweetRuleResponseModel, TSError>) -> Void) {
        cancelTask()

        let getRuleRequest = GetRuleRequest()
        guard let request = RequestFactory.request(for: getRuleRequest) else {
            completion(.failure(.network(string: "Invalid url")))
            return
        }

        task = RequestService().loadData(request: request, completion: self.networkResult(completion: completion))
    }

    func addRule(with keyword: String, completion: @escaping (Result<TweetRuleResponseModel, TSError>) -> Void) {
        cancelTask()

        let addRuleRequest = AddRuleRequest(with: keyword)
        guard let request = RequestFactory.request(for: addRuleRequest) else {
            completion(.failure(.network(string: "Invalid url")))
            return
        }

        task = RequestService().loadData(request: request, completion: self.networkResult(completion: completion))
    }

    func deleteRules(
        with ruleIds: [String],
        completion: @escaping (Result<TweetDeleteRuleResponseModel, TSError>) -> Void
    ) {
        cancelTask()

        let deleteRuleRequest = DeleteRuleRequest(with: ruleIds)
        guard let request = RequestFactory.request(for: deleteRuleRequest) else {
            completion(.failure(.network(string: "Invalid url")))
            return
        }

        task = RequestService().loadData(request: request, completion: self.networkResult(completion: completion))
    }

    func fetchFeeds(_ completion: @escaping FetchFeedsCompletionClosure) {
        cancelTask()

        let connectStreamRequest = ConnectStreamRequest()
        guard let request = RequestFactory.request(for: connectStreamRequest) else {
            completion(.failure(.network(string: "Invalid url")))
            return
        }

        task = RequestService().connect(request: request) { result in
            switch result {
            case .task(let data):
                if let feedResponseList = TweetParseHelper.processTweet(with: data), !feedResponseList.isEmpty {
                    completion(.newData(feedResponseList))
                } else {
                    completion(.failure(.custom(string: "No data available")))
                }
                
            case .finished(let error):
                completion(.failure(.custom(string: "Streaming did finish")))
            case .timeout:
                completion(.needToReconnect)
            case .canceled: break
            }
        }
    }
}
