//
//  Organization.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/18/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import Foundation
import ObjectMapper

class BrowseOrgs: Mappable {
    
    var id: String!
    var name: String!
    var description: String!
    var introURL: NSURL!
    var website: String!
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        
        id <- map["_id"]
        name <- map["name"]
        description <- map["description"]
        introURL <- (map["introUrl"], URLTransform())
        website <- (map["website"])
    }
}
