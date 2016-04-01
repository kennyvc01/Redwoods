//
//  CharitySearchTableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/26/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CharitySearchTableViewController: UITableViewController {

    var objects: [JSON] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseJson()
        
        //formatting
        UINavigationBar.appearance().barTintColor = UIColor(red: 55.0/255.0, green: 55.0/255.0, blue: 55.0/255.0, alpha: 1.0);
        self.navigationController!.navigationBar.tintColor = UIColor(red: 76.0/255.0, green: 288.0/255.0, blue: 144.0/255.0, alpha: 1.0);
        
    }
    func parseJson(){
        

        
        let user: String = KeychainWrapper.stringForKey("username")!
        let password: String = KeychainWrapper.stringForKey("password")!
        
        print(user)
        //Credentials for basic authentication using text fields for username and password
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        //GET Method for api/orgs
        Alamofire.request(.GET, "https://redwoods-engine-test.herokuapp.com/api/orgs", headers: headers)
            .response { (request, response, json, error) in
                
                //store json result in objects array
                if json != nil {
                    var jsonObj = JSON(data: json!)
                    if let data = jsonObj[].arrayValue as [JSON]?{
                        self.objects = data
                        self.tableView.reloadData()
                    }
                }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSkip(sender: AnyObject) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FeedViewController") as UIViewController
        self.presentViewController(viewController, animated: false, completion: nil)
        
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.objects.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CharitySearchTableViewCell
        let data = objects[indexPath.row]
        
        if let charityName = data["name"].string{
            cell.lblCharity.text = charityName
        }
        
        if let charityDescription = data["description"].string{
            cell.lblCharityDescription.text = charityDescription
        }
        if let charityWebsite = data["website"].string{
            
            cell.txtWebsite.text = charityWebsite
        }

        return cell
    }
    
    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Segue" {
            
            let dvc = segue.destinationViewController as! DonationViewController
            
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
            let data = objects[indexPath.row]
            
            dvc.CharityLabel = data["name"].string!
            dvc.orgId = data["_id"].string!

        }
    }



    

}
