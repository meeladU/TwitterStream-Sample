//
//  GetRuleRequestTests.swift
//  TwitterStream-SampleTests
//
//

import XCTest
@testable import TwitterStream_Sample

class GetRuleRequestTests: XCTestCase {
    var subject: GetRuleRequest!
    override func setUpWithError() throws {
        subject = GetRuleRequest()
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    func testGetRuleRequest() {
        XCTAssertNotNil(subject)
        XCTAssertEqual(subject.baseUrl(), Constants.streamAPIBaseURLString)
        XCTAssertEqual(subject.contentType(), "application/json")
        XCTAssertEqual(subject.endPoint(), Constants.rulesAPIEndPoint)
        XCTAssertEqual(subject.requestType(), .GET)
        XCTAssertEqual(subject.bearerToken(), Constants.bearerToken)
    }
}
