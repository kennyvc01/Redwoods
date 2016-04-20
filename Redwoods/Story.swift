//
//  Story.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/18/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import Foundation
import ObjectMapper
import AVFoundation

class Story: Mappable {
    
    var organization: Organization!
    var description: String!
    var link: NSURL!
    var timestamp: NSDate!
    
    var asset: AVAsset?
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        
        description <- map["description"]
        link <- (map["link"], URLTransform())
        timestamp <- (map["timestamp"], DateTransform())
    }
}