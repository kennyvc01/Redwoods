//
//  DonationViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/26/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit

class DonationViewController: UIViewController {

   
    @IBOutlet weak var lblCharity: UILabel!
    @IBOutlet weak var txtDonation: UITextField!
    
    var CharityLabel = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblCharity.text = self.CharityLabel + " is an amazing organization!"
        self.txtDonation.becomeFirstResponder()
        
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
