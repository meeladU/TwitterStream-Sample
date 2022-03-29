//
//  TweetListRouterInput.swift
//  TwitterStream-Sample
//

import Foundation
import UIKit

protocol TweetListRouterInput: AnyObject {
    func routeToTweetDetailView(model: TweetModel)
}

final class TweetListRouter {
    weak var source: UIViewController?

    init(source: UIViewController) {
        self.source = source
    }
}

extension TweetListRouter: TweetListRouterInput {
    func routeToTweetDetailView(model: TweetModel) {
        let viewController = TweetDetailViewController()
        viewController.tweetObject = model
        source?.navigationController?.pushViewController(viewController, animated: true)
    }
}
