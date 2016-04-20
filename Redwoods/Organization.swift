//
//  Organization.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/18/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import Foundation
import ObjectMapper

class Organization: Mappable {
    
    var id: String!
    var name: String!
    var description: String!
    var introURL: NSURL!
    var website: NSURL!
    var stories: [Story] = []
    var amount: Int!
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        
        id <- map["org._id"]
        name <- map["org.name"]
        description <- map["org.description"]
        introURL <- (map["org.introUrl"], URLTransform())
        website <- (map["org.website"], URLTransform())
        stories <- map["org.stories"]
        amount <- map["amount"]
    }
}
