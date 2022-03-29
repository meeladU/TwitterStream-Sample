//
//  TweetListConfigurator.swift
//  TwitterStream-Sample
//

import Foundation

final class TweetListConfigurator {
    static func configureModule(viewController: TweetListViewController) {
        let service = TwitterService()
        let view = TweetListView()
        let router = TweetListRouter(source: viewController)
        let presenter = TweetListPresenter(viewController: viewController)
        let interactor = TweetListInteractor(presenter: presenter, service: service)

        viewController.tweetListView = view
        viewController.router = router
        viewController.interactor = interactor
    }
}
