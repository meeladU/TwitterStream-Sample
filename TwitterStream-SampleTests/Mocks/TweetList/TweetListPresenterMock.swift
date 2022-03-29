//
//  TweetListPresenterMock.swift
//  TwitterStream-SampleTests
//

import Foundation
@testable import TwitterStream_Sample

class TweetListPresenterMock: TweetListPresenterInput {
    var didRetrieveFeedsCalled = 0
    var didRetriveFeedsFailedCalled = 0
    var didSetRuleFailedCalled = 0
    
    func didRetrieveFeeds(_ searchedFeeds: [FeedResponseModel]) {
        didRetrieveFeedsCalled += 1
    }

    func didRetriveFeedsFailed(with error: TSError) {
        didRetriveFeedsFailedCalled += 1
    }

    func didSetRuleFailed(with error: TSError) {
        didSetRuleFailedCalled += 1
    }
}
