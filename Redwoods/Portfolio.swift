//
//  Portfolio.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/20/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import Foundation
import ObjectMapper

class Portfolio: Mappable {

    var profile: Profile!
    var orgId: String!
    var name: String!
    var amount: Int!
    var paymentDay: Int!
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        
        orgId <- map["org._id"]
        name <- map["org.name"]
        amount <- map["amount"]
        paymentDay <- map["payment_date"]
        
    }
}

