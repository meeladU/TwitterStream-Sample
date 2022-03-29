//
//  FetchTweetsRequest.swift
//  TwitterStream-Sample
//

import Foundation

class ConnectStreamRequest: ApiRequestProtocol {
    func endPoint() -> String {
        Constants.connectStreamAPIEndPoint
    }

    func requestType() -> RequestFactory.Method {
        .GET
    }
}
