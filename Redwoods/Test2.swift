//
//  Test2.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/29/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Test2: UIViewController {
    var objects: [JSON] = []
    var object2: [JSON] = []
    var objects3: [JSON] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseJson()
        
        
        
        
    }
    func parseJson(){
        
        
        
        let user: String = KeychainWrapper.stringForKey("username")!
        let password: String = KeychainWrapper.stringForKey("password")!
        
        //print(user)
        //Credentials for basic authentication using text fields for username and password
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        //GET Method for api/orgs
        Alamofire.request(.GET, "https://redwoods-engine-test.herokuapp.com/api/feed", headers: headers)
            .response { (request, response, json, error) in
                
                //store json result in objects array
                if json != nil {
                    var jsonObj = JSON(data: json!)
                    if let data = jsonObj[].arrayValue as [JSON]?{
                        self.objects = data
                        //print(self.objects[0]["org"]["stories"][0])
                        for (index, value) in self.objects.enumerate() {
                            //print(self.objects[index]["org"]["stories"])
                            let data = self.objects[index]["org"]["stories"].arrayValue as [JSON]?
                            self.object2 = data!
                            //print(self.object2)
                            for (index, value) in self.object2.enumerate() {
                              //  print(self.object2[index]["link"])
                                
                                self.objects3.append(self.object2[index]["link"])
                                
                            }
                        }
                        print(self.objects3[3])
                    }
                }
                
                
//
//                let json = JSON(data: json!)
//                for (index, object) in json {
//                    print(object["org"]["stories"])
//                    //self.objects.append(object["org"]["stories"])
//                    
//                }
        
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
