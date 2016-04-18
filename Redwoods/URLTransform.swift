//
//  URLTransform.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/18/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import Foundation
import ObjectMapper

class DateTransform: TransformType {
    
    typealias Object = NSDate
    typealias JSON = String
    
    let dateFormatter: NSDateFormatter
    
    init(format: String? = "yyyy-MM-dd HH:mm:ss") {
        
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
    }
    
    func transformFromJSON(value: AnyObject?) -> Object? {
        
        if let date = value as? JSON {
            
            dateFormatter.locale = NSLocale(localeIdentifier: "en")
            
            return dateFormatter.dateFromString(date)
        }
        
        return nil
    }
    
    func transformToJSON(value: Object?) -> JSON? {
        
        if let date = value {
            
            return dateFormatter.stringFromDate(date)
        }
        
        return nil
    }
}

class URLTransform: TransformType {
    
    typealias Object = NSURL
    typealias JSON = String
    
    func transformFromJSON(value: AnyObject?) -> Object? {
        
        if let url = value as? JSON {
            
            return NSURL(string: url)
        }
        
        return nil
    }
    
    func transformToJSON(value: Object?) -> JSON? {
        
        if let url = value {
            
            return url.absoluteString
        }
        
        return nil
    }
}