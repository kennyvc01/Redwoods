//
//  RestApiManager.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/22/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//
////THIS IS ONLY USED TO TEST REST CALLS

import Alamofire

class RestApiManager: UIViewController {

    var jsonArray:NSMutableArray?
    var newArray: Array<String> = []
    let user = "kennyvc01"
    let password = "kennyvc01"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        
//        let parameters = [
//            "username": self.user,
//            "password": self.password
//        ]
//        
//        Alamofire.request(.POST, "https://redwoods-engine-test.herokuapp.com/api/user/register", parameters: parameters, encoding: .JSON)
//            .responseJSON { response in
//                
//                                if let _ = response.result.error {
//                                    print("incorrect credentials")
//                                } else { //no errors
//                                    let statusCode = (response.response?.statusCode)!
//                                    print(statusCode)
//                                }
//                                         }

        
//        
//        
//        
//        
//        
//        
//        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
//        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
//        
//        
//        let headers = ["Authorization": "Basic \(base64Credentials)"
//                        ,"Content-Type": "application/x-www-form-urlencoded"]
//        
//        Alamofire.request(.GET, "https://redwoods-engine-test.herokuapp.com/api/users", headers: headers)
//            .responseJSON { response in
//                
//                if let _ = response.result.error {
//                    print("incorrect credentials")
//                } else { //no errors
//                    print(response.result.value)
//                    
//                    
//                    if let JSON = response.result.value {
//                        self.jsonArray = JSON as? NSMutableArray
//                        for item in self.jsonArray! {
//                            print(item)
//                            let string = item
//                            print("String is \(string)")
//                            
//                            self.newArray.append(string as! String)
//                        }
//                        
//                        print("New array is \(self.newArray)")
//                        
//                      
//                    }
//                }
//                         }

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
