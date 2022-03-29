//
//  TweetListEntity.swift
//  TwitterStream-Sample
//
//  Created by Milad Jabbarzade on 3/29/22.
//

import Foundation

struct FeedResponseModel: Decodable {
    let feed: FeedModel

    enum CodingKeys: String, CodingKey {
        case feed = "data"
    }
}

struct FeedModel: Decodable {
    let feedId: String
    let text: String?
    let geo: FeedGeoModel?

    enum CodingKeys: String, CodingKey {
        case feedId = "id"
        case text
        case geo
    }
}

struct FeedGeoModel: Decodable {
    let type: String?
    let coordinates: [Double]?
}
