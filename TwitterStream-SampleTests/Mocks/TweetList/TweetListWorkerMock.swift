//
//  TweetListWorkerMock.swift
//  TwitterStream-SampleTests
//

import Foundation
@testable import TwitterStream_Sample

class TweetListWorkerMock: TweetListWorkerInput {
    var getRulesCalled = 0
    var deleteRulesCalled = 0
    var addRulesCalled = 0
    var fetchFeedsCalled = 0
    var sendSuccesReeponseInGetRules = false
    var sendSuccesReeponseInDeleteRules = false
    var sendSuccesReeponseInAddRules = false
    var sendSuccesReeponseInFetchFeeds = false
    var sendRuleObject = false

    func getRules(_ completion: @escaping (Result<TweetRuleResponseModel, TSError>) -> Void) {
        getRulesCalled += 1
        if sendSuccesReeponseInGetRules {
            if sendRuleObject {
                let tweetRuleObject = TweetRuleModel(id: "1242354623", value: "I smaple:1", tag: "search for I")
                let tweetResponseObject = TweetRuleResponseModel(rules: [tweetRuleObject])
                completion(.success(tweetResponseObject))
            } else {
                completion(.success(TweetRuleResponseModel(rules: [TweetRuleModel]())))
            }

            return
        }
        completion(.failure(.network(string: "Error in get rules")))
    }

    func deleteRules(with ruleIdList: [String], completion: @escaping (Result<TweetDeleteRuleResponseModel, TSError>) -> Void) {
        deleteRulesCalled += 1
        if sendSuccesReeponseInDeleteRules {
            let tweetDeleteRuleObject = TweetDeleteRuleModel(deleted: 1)
            let deleteRuleSummaryObject = TweetDeleteRuleSummaryModel(summary: tweetDeleteRuleObject)
            let tweetDeleteRuleResponseObject = TweetDeleteRuleResponseModel(meta: deleteRuleSummaryObject)
            completion(.success(tweetDeleteRuleResponseObject))
            return
        }
        completion(.failure(.network(string: "Error in delete rules")))
    }

    func addRule(with keyword: String, completion: @escaping (Result<TweetRuleResponseModel, TSError>) -> Void) {
        addRulesCalled += 1
        if sendSuccesReeponseInAddRules {
            let tweetRuleObject = TweetRuleModel(id: "1242354623", value: "I smaple:1", tag: "search for I")
            let tweetResponseObject = TweetRuleResponseModel(rules: [tweetRuleObject])
            completion(.success(tweetResponseObject))
            return
        }
        completion(.failure(.network(string: "Error in get rules")))
    }

    func fetchFeeds(_ completion: @escaping FetchFeedsCompletionClosure) {
        fetchFeedsCalled += 1
        if sendSuccesReeponseInFetchFeeds {
            let geoObject = FeedGeoModel(type: "coordinate", coordinates: [40.74118764, -73.9998279])
            let feedObject = FeedModel(feedId: "3463574574", text: "Hello tweet", geo: geoObject)
            let feedResponseObject = FeedResponseModel(feed: feedObject)
            completion(.success([feedResponseObject]))
            return
        }
        completion(.failure(.network(string: "Error in fetch feeds")))
    }
}
