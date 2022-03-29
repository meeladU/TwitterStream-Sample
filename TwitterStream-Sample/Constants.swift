//
//  Constants.swift
//  TwitterStream-Sample
//
//  Created by Milad Jabbarzade on 3/28/22.
//

import Foundation


struct Constants {
    static let streamAPIBaseURLString = "https://api.twitter.com/2/tweets/search/stream"
    static let rulesAPIEndPoint = "/rules"
    static let connectStreamAPIEndPoint = "?tweet.fields=created_at&expansions=author_id,geo.place_id&user.fields=created_at&place.fields=contained_within,country,full_name,geo,id,name,place_type"
    static let bearerToken = "Bearer Token"
}

struct TwitterServiceConstants {
    struct RequestParamKeys {
        static let add = "add"
        static let delete = "delete"

        static let tag = "tag"
        static let value = "value"
        static let ids = "ids"
    }

    struct RequestParamValues {
        static let sample = "sample"
    }
}
