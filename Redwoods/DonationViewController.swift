//
//  DonationViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/26/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DonationViewController: UIViewController {

   
    @IBOutlet weak var lblCharity: UILabel!
    @IBOutlet weak var txtAmount: UITextField!
    
    var CharityLabel = ""
    var orgId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblCharity.text = self.CharityLabel + " is an amazing organization!"
        self.txtAmount.becomeFirstResponder()
        
          }

    @IBAction func btnSubmitDonation(sender: AnyObject) {
        
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        let todayString:String = dateFormatter.stringFromDate(todaysDate)

        
        //Added [ String : AnyObject] to handle int type
        let parameters : [ String : AnyObject] =  [
            "amount": Int(self.txtAmount.text!)!,
            "payment_date": Int(todayString)!
        ]
        let user: String = KeychainWrapper.stringForKey("username")!
        let password: String = KeychainWrapper.stringForKey("password")!
        
       
        //Credentials for basic authentication using text fields for username and password
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        //PUT to api/user/register
       
        Alamofire.request(.PUT, "https://redwoods-engine-test.herokuapp.com/api/profiles/portfolio/" + orgId, headers: headers, parameters: parameters)
            .response { (request, response, json, error) in
                
                
                //store json result in objects array
                if json != nil {
                    let jsonObj = JSON(data: json!)
                    print(jsonObj)
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FeedViewController") as UIViewController
                    self.presentViewController(viewController, animated: false, completion: nil)
                }

                
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
