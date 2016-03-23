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
        
        
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        Alamofire.request(.GET, "https://redwoods-engine-test.herokuapp.com/api/profile", headers: headers)
            .responseJSON { response in
                
                if let _ = response.result.error {
                    print("incorrect credentials")
                } else { //no errors
                    let statusCode = (response.response?.statusCode)!
                    print(statusCode)
                }
               // debugPrint(response)
               // print(response.request)  // original URL request
                //print(response.response) // URL response
               // print(response.data)     // server data
               // print(response.result)   // result of response serialization
                
//                if let  JSON = response.result.value {
//                    self.jsonArray = JSON as? NSMutableArray
//                    for item in self.jsonArray! {
//                        
//                        print(item)
//                        let string = item
//                        print("String is \(string)")
//                        self.newArray.append(string as! String)
                   // }
                    
                  //  print("New array is \(self.newArray)")
                    
                    
              //  }
            }
        
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
