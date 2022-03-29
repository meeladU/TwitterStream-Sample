//
//  TweetListRouterMock.swift
//  TwitterStream-SampleTests
//

import Foundation
@testable import TwitterStream_Sample

class TweetListRouterMock: TweetListRouterInput {
    func routeToTweetDetailView() { }
    
    var routeToMapViewCalled = 0
    func routeToMapView() {
        routeToMapViewCalled += 1
    }
}
