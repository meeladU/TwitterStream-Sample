//
//  DeleteRuleRequest.swift
//  TwitterStream-Sample
//

import Foundation

class DeleteRuleRequest: ApiRequestProtocol {
    let ruleIds: [String]

    init(with ruleIds: [String]) {
        self.ruleIds = ruleIds
    }

    func endPoint() -> String {
        Constants.rulesAPIEndPoint
    }

    func requestType() -> RequestFactory.Method {
        .POST
    }

    func bodyParams() -> [String: Any]? {
        let rules = [TwitterServiceConstants.RequestParamKeys.ids: ruleIds]
        let params = [TwitterServiceConstants.RequestParamKeys.delete: rules]
        return params
    }
}
