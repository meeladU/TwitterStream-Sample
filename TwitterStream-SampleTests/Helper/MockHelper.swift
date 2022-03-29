//
//  MockHelper.swift
//  TwitterStream-SampleTests
//
//  

import Foundation
@testable import TwitterStream_Sample

class MockHelper {
    static func fetchCorrectTweetMockData() -> Data? {
        fetchTweetMockData(from: "MockTweets")
    }

    static func fetchIncorrectTweetMockData() -> Data? {
        fetchTweetMockData(from: "IncorrectMockTweets")
    }

    private static func fetchTweetMockData(from fileName: String) -> Data? {
        guard let data = FileManager.readJson(forResource: fileName) else {
            return nil
        }
        return data
    }
}
