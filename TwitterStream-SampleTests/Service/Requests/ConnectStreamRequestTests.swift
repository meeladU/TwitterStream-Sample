//
//  ConnectStreamRequestTests.swift
//  TwitterStream-SampleTests
//

import XCTest
@testable import TwitterStream_Sample

class ConnectStreamRequestTests: XCTestCase {
    var subject: ConnectStreamRequest!
    override func setUpWithError() throws {
        subject = ConnectStreamRequest()
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    func testConnectStreamRequest() {
        XCTAssertNotNil(subject)    
        XCTAssertEqual(subject.baseUrl(), Constants.streamAPIBaseURLString)
        XCTAssertEqual(subject.contentType(), "application/json")
        XCTAssertEqual(subject.endPoint(), Constants.connectStreamAPIEndPoint)
        XCTAssertEqual(subject.requestType(), .GET)
        XCTAssertEqual(subject.bearerToken(), Constants.bearerToken)
        XCTAssertNotNil(subject.bodyParams)
    }
}
