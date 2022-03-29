//
//  TweetListPresenter.swift
//  TwitterStream-Sample
//

import Foundation
import DifferenceKit

protocol TweetListPresenterInput: AnyObject {
    func didRetrieveFeeds(_ searchedFeeds: [FeedResponseModel])
    func didRetriveFeedsFailed(with error: TSError)
    func didSetRuleFailed(with error: TSError)
    func tryingReconnect()
}

final class TweetListPresenter {
    weak var viewController: TweetListViewControllerProtocol?
    
    init(viewController: TweetListViewControllerProtocol) {
        self.viewController = viewController
    }
    
    private func getCurrenctFormattedClock() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: Date())
    }
}

extension TweetListPresenter: TweetListPresenterInput {
    
    func tryingReconnect() {
        DispatchQueue.main.sync {
            viewController?.showActivityIndicator()
        }
    }
    
    func didRetrieveFeeds(_ searchedFeeds: [FeedResponseModel]) {
        let feeds = searchedFeeds.compactMap {$0.feed.text }.map { TweetModel(id: UUID(), text: $0) }
        let newSection = ArraySection<String, TweetModel>.init(model: getCurrenctFormattedClock(), elements: feeds)
        DispatchQueue.main.async {
            self.viewController?.didRetriveNewFeeds(with: newSection)
            self.viewController?.hideActivityIndicator()
        }

    }

    func didRetriveFeedsFailed(with error: TSError) {
        DispatchQueue.main.async {
            self.viewController?.didRetriveFeedsFailed(with: error.localizedDescription)
        }
    }

    func didSetRuleFailed(with error: TSError) {
        DispatchQueue.main.async {
            self.viewController?.didSetRuleFailed(with: error.localizedDescription)
        }
    }
}
