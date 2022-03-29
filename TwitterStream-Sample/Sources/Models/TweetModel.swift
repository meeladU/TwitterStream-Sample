//
//  TweetModel.swift
//  TwitterStream-Sample
//
//

import Foundation
import DifferenceKit

struct TweetModel: Differentiable, Equatable {
    var id: UUID
    
    
    var differenceIdentifier: UUID {
        return id
    }
    
    let text: String
}
