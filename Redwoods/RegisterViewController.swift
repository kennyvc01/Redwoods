//
//  RegisterViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/23/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
//    var jsonArray:NSMutableArray?
//    var newArray: Array<String> = []
    
    @IBAction func btnSubmit(sender: AnyObject) {
        
        let user = txtEmail.text as String!
        let password = txtPassword.text as String!
        let parameters = [
            "username": user,
            "password": password
        ]
        
        Alamofire.request(.POST, "https://redwoods-engine-test.herokuapp.com/api/user/register", parameters: parameters, encoding: .JSON)
            
                
                .responseJSON { response in
                    
                    if let _ = response.result.error {
                        print("Connection error")
                        
                    } else { //No connection error
                       
                       //get JSON result
                        if let JSON = response.result.value {
                        let response = JSON as! NSDictionary
                        //get value of msg key from JSON string
                            if let msg = response.objectForKey("msg"){
                            
                                if msg as! String == "username already exists"{
                                    print("user already exists")
                                
                                    //Alert if user already exists.  Two buttons on the alert:  Ok and Reset Account
                                    let alertController = UIAlertController(title: "Username already exists", message: "Please enter a different username or reset your account.", preferredStyle: .Alert)
                                    //Ok button on alert
                                    let OKAction = UIAlertAction(title: "Ok", style: .Default) { (action) in
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

                                }//if msg as! String == "username already exists"
                                
                                }//if let msg = response.objectForKey("msg")
                                else {
                                    print("successfully registered")
                                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FeedViewController") as UIViewController
                                    self.presentViewController(viewController, animated: false, completion: nil)
                                }
                        
                        }
                    }
                    
                }
        
        
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Exit button
    @IBAction func btnExit(sender: AnyObject) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainLaunchPageViewController") as UIViewController
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    

}
