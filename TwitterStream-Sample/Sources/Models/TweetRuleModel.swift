//
//  TweetRule.swift
//  TwitterStream-Sample
//
//

import Foundation

struct TweetRuleResponseModel: Decodable {
    let rules: [TweetRuleModel]

    enum CodingKeys: String, CodingKey {
        case rules = "data"
    }
}

struct TweetRuleModel: Decodable {
    let id: String
    let value: String?
    let tag: String?
}

struct TweetDeleteRuleResponseModel: Decodable {
    let meta: TweetDeleteRuleSummaryModel
}

struct TweetDeleteRuleSummaryModel: Decodable {
    let summary: TweetDeleteRuleModel
}

struct TweetDeleteRuleModel: Decodable {
    let deleted: Int?
}
