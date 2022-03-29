//
//  AddRuleRequestTests.swift
//  TwitterStream-SampleTests
//

import XCTest
@testable import TwitterStream_Sample

class AddRuleRequestTests: XCTestCase {
    var subject: AddRuleRequest!
    override func setUpWithError() throws {
        subject = AddRuleRequest(with: "I")
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    func testAddRuleRequest() {
        XCTAssertNotNil(subject)
        XCTAssertEqual(subject.baseUrl(), Constants.streamAPIBaseURLString)
        XCTAssertEqual(subject.contentType(), "application/json")
        XCTAssertEqual(subject.keyword, "I")
        XCTAssertEqual(subject.endPoint(), Constants.rulesAPIEndPoint)
        XCTAssertEqual(subject.requestType(), .POST)
        XCTAssertEqual(subject.bearerToken(), Constants.bearerToken)
        XCTAssertNotNil(subject.bodyParams)
    }

}
