//
//  PortfolioTableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/31/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PortfolioTableViewController: UITableViewController {
    
    var objects = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navbar Format
        //UINavigationBar.appearance().barTintColor = UIColor(red: 55.0/255.0, green: 55.0/255.0, blue: 55.0/255.0, alpha: 1.0);
        //self.navigationController!.navigationBar.tintColor = UIColor(red: 76.0/255.0, green: 288.0/255.0, blue: 144.0/255.0, alpha: 1.0);
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.objects.removeAll()
        //set username and password = key chain
        let user: String = KeychainWrapper.stringForKey("username")!
        let password: String = KeychainWrapper.stringForKey("password")!
        
        //Credentials for basic authentication using text fields for username and password
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        //GET Method for api/feed
        Alamofire.request(.GET, "https://redwoods-engine-test.herokuapp.com/api/profile", headers: headers)
            .response { (request, response, json, error) in
                //if json api/feed returns results then pars json using the parseJSON function
                if json != nil {
                    let json = JSON(data: json!)
                    self.parseJSON(json)
                }
        }
        
        
    }
    
    //function to parse and load JSON results in objects array as ["storyLink","storyTimestamp","description","org"]
    func parseJSON(json: JSON) {
        //loop through json results
        for result in json["portfolio"].arrayValue {
            let org = result["org"]["name"].stringValue
            let orgId = result["org"]["_id"].stringValue
            let amount  = result["amount"].stringValue
            let paymentDate = result["payment_date"].stringValue
            print(json["portfolio"])
            let obj = ["org": org, "orgId": orgId,"amount": amount, "paymentDate": paymentDate]
            objects.append(obj)

        }
        tableView.reloadData()
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //Number of table view sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    //Number of table view rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.objects.count
    }
    
    
    
    //populate each cell based on index path of array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PortfolioTableViewCell
        
        cell.lblCharityName.text = self.objects[indexPath.row]["org"]! as String
        cell .lblDonationAmount.text = "Monthly Donation Amount: $" + self.objects[indexPath.row]["amount"]! as String
        cell .lblDonationDay.text = "Collection Day: " + self.objects[indexPath.row]["paymentDate"]! as String
        
        

        return cell
    }
    
    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Segue" {
            
            let evc = segue.destinationViewController as! EditDonationViewController
            
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
            let data = objects[indexPath.row]
            
            evc.CharityLabel = data["org"]!
            evc.orgId = data["orgId"]!
            evc.amount = data["amount"]!
            evc.paymentDate = data["paymentDate"]!
        }
    }

    

}
