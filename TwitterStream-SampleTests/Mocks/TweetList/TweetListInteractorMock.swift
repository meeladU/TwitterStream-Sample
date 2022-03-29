//
//  TweetListInteractorMock.swift
//  TwitterStream-SampleTests
//

import Foundation
@testable import TwitterStream_Sample

class TweetListInteractorMock: TweetListInteractorInput {
    var searchTweetCalled = 0
    
    func searchTweet(with keyword: String) {
        searchTweetCalled += 1
    }
}
