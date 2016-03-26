//
//  DonationViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/26/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit

class DonationViewController: UIViewController {

    @IBOutlet weak var lblDonation: UILabel!
    @IBOutlet weak var txtDonation: UITextField!
    @IBOutlet weak var lblMaxDonation: UILabel!
    @IBOutlet weak var txtMaxDonation: UITextField!
    @IBOutlet weak var lblCharity: UILabel!
    
    var CharityLabel = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblCharity.text = self.CharityLabel + " is an amazing organization!"

        
        
        self.lblDonation.hidden = true
        self.txtDonation.hidden = true
        self.lblMaxDonation.hidden = true
        self.txtMaxDonation.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMonthly(sender: AnyObject) {
        if self.lblMaxDonation.hidden == false{
            self.lblMaxDonation.hidden = true
            self.txtMaxDonation.hidden = true
        }
        
        self.lblDonation.hidden = false
        self.txtDonation.hidden = false
        self.lblDonation.text = "how much would you like to donate?"
        
        self.txtDonation.becomeFirstResponder()
        
        
    }

    @IBAction func btnPercent(sender: AnyObject) {
        self.lblDonation.hidden = false
        self.txtDonation.hidden = false
        self.lblMaxDonation.hidden = false
        self.txtMaxDonation.hidden = false
        self.lblDonation.text = "what percent do you want to donate?"
        self.lblMaxDonation.text = "what's the maximum you want to donate per month?"
        
        self.txtDonation.becomeFirstResponder()
        
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
