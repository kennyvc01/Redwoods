//
//  Profile.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/20/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import Foundation
import ObjectMapper

class Profile: Mappable {
    
    var portfolio: [Portfolio] = []
    var userId: String!
    var username: String!
    var admin: Bool = false
    var bankId: String!
    
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        
        userId <- map["user._id"]
        username <- map["user.username"]
        admin <- map["user.admin"]
        portfolio <- map["portfolio"]
        bankId <- map["bank_acct._id"]
        
    }
}



