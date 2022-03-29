//
//  TwitterServiceMock.swift
//  TwitterStream-SampleTests
//
// 

import Foundation
@testable import TwitterStream_Sample

class TwitterServiceMock: TwitterServiceProtocol {
var getRulesCalled = 0
    var deleteRulesCalled = 0
    var addRulesCalled = 0
    var fetchFeedsCalled = 0

    func getRules(_ completion: @escaping (Result<TweetRuleResponseModel, TSError>) -> Void) {
        getRulesCalled += 1
    }

    func addRule(with keyword: String, completion: @escaping (Result<TweetRuleResponseModel, TSError>) -> Void) {
        addRulesCalled += 1
    }

    func deleteRules(with ruleIds: [String], completion: @escaping (Result<TweetDeleteRuleResponseModel, TSError>) -> Void) {
        deleteRulesCalled += 1
    }

    func fetchFeeds(_ completion: @escaping FetchFeedsCompletionClosure) {
        fetchFeedsCalled += 1
    }

    
}
