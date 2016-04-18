//
//  Redwoods.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/18/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import Foundation
import Moya

enum Redwoods {
    case Feed
}

extension Redwoods: TargetType {
    var baseURL: NSURL {
        return NSURL(string: "https://redwoods-engine-test.herokuapp.com/api")!
    }
    var path: String {
        switch self {
        case .Feed:
            return "/feed"
        }
    }
    var method: Moya.Method {
        switch self {
        case .Feed:
            return .GET
        }
    }
}