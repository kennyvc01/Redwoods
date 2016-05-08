//
//  ProfileTableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/10/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Moya
import Moya_ObjectMapper

class ProfileTableViewController: UITableViewController {
    
    var publicToken = ""
    var account = ""
    
    @IBOutlet weak var lblBank: UILabel!
    //Moya Provider
    let provider = MoyaProvider<Redwoods>(plugins: [CredentialsPlugin { _ -> NSURLCredential? in
        return NSURLCredential(
            user: KeychainWrapper.stringForKey("username")!,
            password: KeychainWrapper.stringForKey("password")!,
            persistence: .None
        )
    }])
    var error: ErrorType? {
        didSet {
            print(error)
        }
    }
    var profile: [Profile] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Check if user has a bank account linked.  First check if public token = "".  Need to check this since the post is done after the vc is loaded.  checkBank() is called in the Post function too.
        if publicToken == "" {
            checkBank()
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)

        //Check if plaid variables are set.  The variables come from the LinkViewController.m.  If set, execute function to post account_id and public_token
        if self.publicToken != "" && self.account != "" {
            postPlaid()
            print("public token: \(publicToken) account: \(account)")
        } else {
            print("plaid variables are empty")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function used to check bank account.  If user has bank account, set lblBank to "Change Bank Account" else "Link Bank Account".
    func checkBank() {
        
        //Moya for GET Profile.  This is used to see if the user has a bank account linked.
        provider.requestArray(.Profile, succeed: { (profiles: [Profile]) in
            self.profile = profiles
            //Change bank label depending on if user has an account linked
            if (self.profile[0].bankId != nil) {
                self.lblBank.text = "Change Bank Account"
            } else {
                self.lblBank.text = "Link Bank Account"
            }
        }) { (error) in
            self.error = error
            print(error)
        }
    }
    
    
    //Button to link or change bank.  If user already has an account, segue to ChangeBank.  If user doesn't have account then segue to LinkBank
    @IBAction func btnBank(sender: AnyObject) {
        if (self.profile[0].bankId != nil) {
            performSegueWithIdentifier("ChangeBank", sender: self)
        } else {
            performSegueWithIdentifier("LinkBank", sender: self)
        }
    }
    @IBAction func btnLogout(sender: AnyObject) {
        KeychainWrapper.removeObjectForKey("username")
        KeychainWrapper.removeObjectForKey("password")
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainLaunchPageViewController") as UIViewController
        self.presentViewController(viewController, animated: true, completion: nil)
        //self.performSegueWithIdentifier("Segue", sender: sender)
        
    }
    
    func postPlaid() {
        //Added [ String : AnyObject] to handle int type
        let parameters : [ String : AnyObject] =  [
            "account_id": self.account,
            "public_token": self.publicToken
        ]
        let user: String = KeychainWrapper.stringForKey("username")!
        let password: String = KeychainWrapper.stringForKey("password")!
        
        //Credentials for basic authentication using text fields for username and password
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        Alamofire.request(.POST, "https://redwoods-engine-test.herokuapp.com/api/bankaccounts/create/", headers: headers, parameters: parameters)
            .response { (request, response, json, error) in
                
            if error != nil {
                //change lblBank Accordingly
                print("didn't post account_id and public token \(response)")
            } else {
                print("posted account_id and public_token \(response) \(json)")
                //change lblBank Accordingly
                self.checkBank()
            }
        }
    }
}
