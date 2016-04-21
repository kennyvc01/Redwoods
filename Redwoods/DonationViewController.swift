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
import AVKit
import AVFoundation

class DonationViewController: UIViewController, UIPickerViewDelegate {

   
    @IBOutlet weak var lblCharity: UILabel!
    @IBOutlet weak var lblDonor: UIButton!
    @IBOutlet weak var pkPicker: UIPickerView!
    @IBOutlet weak var vwMovieView: LoopingVideoView!
    
    var CharityLabel = ""
    var orgId = ""
    var donation = ""
    var introUrl : NSURL?
    var Amount = ["5","10","15","20","25","30","35","40","45","50","75","100","150","200","250","300","350","400","500","750","1000"]
    var selectedAmount = "25"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //picker
        pkPicker.selectRow(4, inComponent: 0, animated: true)
        
        
        //charity label
        self.lblCharity.text = self.CharityLabel + " is an amazing organization!"
        
        //button.  if user is donating then "Change Monthly Donation" else "Begin Monthly Donation"
        if self.donation == "I'm donating" {
            
            self.lblDonor.setTitle("Change Monthly Donation", forState: .Normal)
            
        }else{
            
            self.lblDonor.setTitle("Begin Monthly Donation", forState: .Normal)
        }

        //video
        //LoopingVideoView.videoAspect = "Aspect"
        
        self.vwMovieView.fill = true
        
        self.vwMovieView.play(self.introUrl!)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.vwMovieView.pause()
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
    


}
