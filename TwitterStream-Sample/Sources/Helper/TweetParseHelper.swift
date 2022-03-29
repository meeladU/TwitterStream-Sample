//
//  TweetParseHelper.swift
//  TwitterStream-Sample
//
//  Created by Milad Jabbarzade on 3/28/22.
//

import Foundation

class TweetParseHelper {
    static func processTweet(with data: Data?) -> [FeedResponseModel]? {
        guard let data = data, var string = String(data: data, encoding: .utf8) else {
            return nil
        }

        let delimiter = "\r\n"
        string = string.replacingOccurrences(of: "\\r\\n", with: delimiter)
        let chunks = string.components(separatedBy: delimiter)
        let decoder = JSONDecoder()
        var feedresponseList = [FeedResponseModel]()
        chunks.forEach { chunk in
            do {
                guard !chunk.isEmpty, let data = chunk.data(using: .utf8) else {
                    return
                }

                let feedResponse = try decoder.decode(FeedResponseModel.self, from: data)
                feedresponseList.append(feedResponse)
            } catch {
                print("Parsing the data error: " + error.localizedDescription)
            }
        }
        return feedresponseList
    }
}
