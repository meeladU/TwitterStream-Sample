//
//  ApiRequest.swift
//  TwitterStream-Sample
//

import Foundation

protocol ApiRequestProtocol {
    func baseUrl() -> String
    func endPoint() -> String
    func bodyParams() -> [String: Any]?
    func requestType() -> RequestFactory.Method
    func contentType() -> String
    func bearerToken() -> String
}

extension ApiRequestProtocol {
    func baseUrl() -> String {
        Constants.streamAPIBaseURLString
    }

    func contentType() -> String {
        "application/json"
    }

    func bearerToken() -> String {
        Constants.bearerToken
    }

    func bodyParams() -> [String: Any]? {
        nil
    }
}
