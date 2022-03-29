//
//  ErrorExtensions.swift
//  TwitterStream-Sample
//
//  Created by Milad Jabbarzade on 3/29/22.
//

import Foundation

extension Error {
    var code: Int { return (self as NSError).code }
}
