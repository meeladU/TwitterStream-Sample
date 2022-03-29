//
//  GetRuleRequest.swift
//  TwitterStream-Sample
//

import Foundation

class GetRuleRequest: ApiRequestProtocol {
    func endPoint() -> String {
        Constants.rulesAPIEndPoint
    }

    func requestType() -> RequestFactory.Method {
        .GET
    }
}
