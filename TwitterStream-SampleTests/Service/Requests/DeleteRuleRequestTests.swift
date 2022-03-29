//
//  DeleteRuleRequestTests.swift
//  TwitterStream-SampleTests
//

import XCTest
@testable import TwitterStream_Sample

class DeleteRuleRequestTests: XCTestCase {
    var subject: DeleteRuleRequest!
    override func setUpWithError() throws {
        subject = DeleteRuleRequest(with: ["2352324562346", "34636457456746"])
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    func testDeleteRuleRequest() {
        XCTAssertNotNil(subject)
        XCTAssertEqual(subject.ruleIds.count, 2)
        XCTAssertEqual(subject.baseUrl(), Constants.streamAPIBaseURLString)
        XCTAssertEqual(subject.contentType(), "application/json")
        XCTAssertEqual(subject.endPoint(), Constants.rulesAPIEndPoint)
        XCTAssertEqual(subject.requestType(), .POST)
        XCTAssertEqual(subject.bearerToken(), Constants.bearerToken)
        XCTAssertNotNil(subject.bodyParams)
    }
}
