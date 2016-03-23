//
//  LoginViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/25/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
    //Submit button
    @IBAction func btnSubmit(sender: AnyObject) {
        
        let user = txtEmail.text as String!
        let password = txtPassword.text as String!
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        Alamofire.request(.GET, "https://redwoods-engine-test.herokuapp.com/api/profile", headers: headers)
            .responseJSON { response in
                
                if let _ = response.result.error {
                    print("incorrect credentials")
                    
                    //Alert if user enters invalid username or password.  Two buttons on the alert:  Ok and Reset Account
                    let alertController = UIAlertController(title: "Invalid Credentials", message: "You've entered an invalid username/password combination.", preferredStyle: .Alert)
                    //Ok button on alert
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    }
                    alertController.addAction(OKAction)
                    //reset button on alert.  Reset button will present a popup form for user to enter email account
                    let resetAction = UIAlertAction(title: "Reset Account", style: .Default) { (action) in
                        //Reset popup form.  Two buttons: Reset and Cancel
                        let resetController = UIAlertController(title: "Account Reset", message: "Enter your Email to reset your account.", preferredStyle: .Alert)
                        //reset text field for email address
                        resetController.addTextFieldWithConfigurationHandler { (textField) in
                            textField.placeholder = "Email"
                            textField.keyboardType = .EmailAddress
                            
                        }
                        //reset action
                        let resetAction = UIAlertAction(title: "Reset", style: .Default) { (_) in }
                        resetController.addAction(resetAction)
                        //cancel action
                        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
                        resetController.addAction(cancelAction)
                        //preset reset view controller
                        self.presentViewController(resetController, animated: true, completion: nil)
                    }
                    alertController.addAction(resetAction)
                    //preset view controller
                    self.presentViewController(alertController, animated: true) {
                    }

                } else { //no errors
                    let statusCode = (response.response?.statusCode)!
                    print(statusCode)
                    
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FeedViewController") as UIViewController
                    self.presentViewController(viewController, animated: false, completion: nil)
                }
               
        }
        
    }

        


    @IBAction func btnExit(sender: AnyObject) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainLaunchPageViewController") as UIViewController
        self.presentViewController(viewController, animated: true, completion: nil)
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
