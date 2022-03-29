//
//  AddRuleRequest.swift
//  TwitterStream-Sample
//

import Foundation

class AddRuleRequest: ApiRequestProtocol {
    let keyword: String

    init(with keyword: String) {
        self.keyword = keyword
    }

    func endPoint() -> String {
        Constants.rulesAPIEndPoint
    }

    func requestType() -> RequestFactory.Method {
        .POST
    }

    func bodyParams() -> [String: Any]? {
        let ruleValue = "\(keyword) \(TwitterServiceConstants.RequestParamValues.sample):1"
        let tagValue = "\(keyword) text"
        let rules = [
            [
                TwitterServiceConstants.RequestParamKeys.value: ruleValue,
                TwitterServiceConstants.RequestParamKeys.tag: tagValue
            ]
        ]
        let params = [TwitterServiceConstants.RequestParamKeys.add: rules]
        return params
    }
}
