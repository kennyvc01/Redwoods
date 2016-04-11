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

class DonationViewController: UIViewController, UIPickerViewDelegate {

   
    @IBOutlet weak var lblCharity: UILabel!
    @IBOutlet weak var lblDonor: UIButton!
    @IBOutlet weak var pkPicker: UIPickerView!
    
    var CharityLabel = ""
    var orgId = ""
    var donation = ""
    var Amount = ["5","10","15","20","25","30","35","40","45","50","75","100","150","200","250","300","350","400","500","750","1000"]
    var selectedAmount = "25"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pkPicker.selectRow(4, inComponent: 0, animated: true)
        
        self.lblCharity.text = self.CharityLabel + " is an amazing organization!"
        
        if self.donation == "I'm donating" {
            
            self.lblDonor.setTitle("Change Monthly Donation", forState: .Normal)
        
        }else{
            
            self.lblDonor.setTitle("Begin Monthly Donation", forState: .Normal)
        }
        
        
          }

    @IBAction func btnSubmitDonation(sender: AnyObject) {
        
        
        
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        let todayString:String = dateFormatter.stringFromDate(todaysDate)

        
        //Added [ String : AnyObject] to handle int type
        let parameters : [ String : AnyObject] =  [
            "amount": Int(self.selectedAmount)!,
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
                
                if error != nil {
                    self.performSegueWithIdentifier("DonationSegue", sender: sender)
                }
                
                
                //store json result in objects array
                if json != nil {
                    let jsonObj = JSON(data: json!)

                }

        }
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Picker View Data Source
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return self.Amount.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Amount[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.selectedAmount = Amount[row]
        print(self.selectedAmount)
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
