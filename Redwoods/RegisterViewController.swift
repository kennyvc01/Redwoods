//
//  RegisterViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/23/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import Alamofire

class RegisterViewController: UIViewController {

    
    //Outlet variables
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.becomeFirstResponder()
        
    }

    //submit button.  on submit, performs POST to api/user/register using username and password parameters.  If result returns "username already exists", a series of alert controllers are used to have them register or re-enter their credentials.  Else, open FeedViewController.
    @IBAction func btnSubmit(sender: AnyObject) {
        
        let user = txtEmail.text as String!
        let password = txtPassword.text as String!
        let parameters = [
            "username": user,
            "password": password
        ]
        //POST to api/user/register
        Alamofire.request(.POST, "https://redwoods-engine-test.herokuapp.com/api/users/register", parameters: parameters, encoding: .JSON)
                .responseJSON { response in
                    if let _ = response.result.error {//error in response
                        print("Connection error")
                        print(response)
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

                                }//if msg as! String == "username already exists" closing brace
                                
                                }//if let msg = response.objectForKey("msg") closing brace
                                else {
                                    print("successfully registered")
                                    KeychainWrapper.setString(self.txtEmail.text!, forKey: "username")
                                    KeychainWrapper.setString(self.txtPassword.text!, forKey: "password")
                                
                                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Register3") as UIViewController
                                    self.presentViewController(viewController, animated: false, completion: nil)
                                
                                }
                            }
                        }
                    
                    }
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
