//
//  TweetParseHelperTests.swift
//  TwitterStream-SampleTests
//

import XCTest
@testable import TwitterStream_Sample

class TweetParseHelperTests: XCTestCase {
    var correctTweetResponseData: Data?
    var incorrectTweetResponseData: Data?
    override func setUpWithError() throws {
        correctTweetResponseData = MockHelper.fetchCorrectTweetMockData()
        incorrectTweetResponseData = MockHelper.fetchIncorrectTweetMockData()
    }

    override func tearDownWithError() throws {
        correctTweetResponseData = nil
        incorrectTweetResponseData = nil
    }

    func testTweetObjectIsNotNilWhenResponseIsInCorrectFormat() {
        let tweetObject = TweetParseHelper.processTweet(with: correctTweetResponseData)
        XCTAssertNotNil(tweetObject)
    }

    func testTweetObjectHasDataWhenResponseIsInCorrectFormat() {
        let tweetObject = TweetParseHelper.processTweet(with: correctTweetResponseData)
        XCTAssertEqual(tweetObject?.count, 7)
    }

    func testTweetObjectIsNilWhenResponseIsInIncorrectFormat() {
        let tweetObject = TweetParseHelper.processTweet(with: incorrectTweetResponseData)
        XCTAssertNil(tweetObject)
    }
}
