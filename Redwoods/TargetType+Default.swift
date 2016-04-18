//
//  TargetType+Default.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/18/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import ObjectMapper

extension TargetType {
    var url: NSURL { return baseURL.URLByAppendingPathComponent(path) }
    var path: String { switch self { default: return "/" } }
    var method: Moya.Method { switch self { default: return .GET } }
    var parameters: [String: AnyObject]? { switch self { default: return nil } }
    var sampleData: NSData { switch self { default: return NSData() } }
    var request: NSURLRequest { return NSURLRequest(URL: url) }
}

extension MoyaProvider {
    
    func requestArray<T: Mappable>(target: Target, succeed: [T] -> (), fail: Error -> ()) -> Cancellable {
        
        return request(target, completion: { (result) in
            switch result {
            case .Success(let response):
                do {
                    succeed(try response.mapArray())
                } catch {
                    fail(Error.StringMapping(response))
                }
            case .Failure(let error):
                fail(error)
            }
        })
    }
    
    func requestObject<U: Mappable>(target: Target, succeed: U -> (), fail: Error -> ()) -> Cancellable {
        
        return request(target, completion: { (result) in
            switch result {
            case .Success(let response):
                do {
                    succeed(try response.mapObject())
                } catch {
                    fail(Error.StringMapping(response))
                }
            case .Failure(let error):
                fail(error)
            }
        })
    }
}