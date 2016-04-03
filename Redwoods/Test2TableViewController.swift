//
//  Test2TableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/1/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Test2TableViewController: UITableViewController {
    
    var browseOrgobjects = [[String: String]]()
    var feedObjects = [String]()
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.feedObjects.removeAll()
        //set username and password = key chain
        let user: String = KeychainWrapper.stringForKey("username")!
        let password: String = KeychainWrapper.stringForKey("password")!
        
        //Credentials for basic authentication using text fields for username and password
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        //GET Method for api/feed
        Alamofire.request(.GET, "https://redwoods-engine-test.herokuapp.com/api/feed", headers: headers)
            .response { (request, response, json, error) in
                let json = JSON(data: json!)
                self.parseFeedJSON(json)
                self.tableView.reloadData()
        }
        
        //GET Method for api/feed
        Alamofire.request(.GET, "https://redwoods-engine-test.herokuapp.com/api/profile/browseorgs", headers: headers)
            .response { (request, response, json, error) in
                //if json api/feed returns results then pars json using the parseJSON function
                if json != nil {
                    let json = JSON(data: json!)
                    self.parseBrowseOrgJSON(json)
                    self.tableView.reloadData()
                }
        }
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
       
        
        
        
    }
    
    //function to parse and load JSON results in objects array as ["storyLink","storyTimestamp","description","org"]
    func parseFeedJSON(json: JSON) {
        
        for result in json.arrayValue {
            let orgId = result["org"]["_id"].stringValue
            feedObjects.append(orgId)
            print(orgId)
            
           // print(data2)
//            self.feedObjects = data2
//            self.tableView.reloadData()
 //       print(JSON["org"]["_id"])
//        for result in json.arrayValue {
//            let orgId = result["org"]["_id"].stringValue
//            let obj = [orgId]
//            //print(obj)
//            feedObjects = obj
//            print(feedObjects)
//        }
//        print("feed objects added")
    }
    }
    
    
    
    
    
    //function to parse and load JSON results in objects array as ["storyLink","storyTimestamp","description","org"]
    func parseBrowseOrgJSON(json: JSON) {
        //print(json)
        //loop through json results
        for result in json.arrayValue {
            let orgId = result["_id"].stringValue
            let website = result["website"].stringValue
            let description = result["description"].stringValue
            let name = result["name"].stringValue
            let obj = ["orgId": orgId, "website": website, "description": description, "name": name]
            browseOrgobjects.append(obj)
            //print(browseOrgobjects)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return browseOrgobjects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! Test2TableViewCell
        let data = browseOrgobjects[indexPath.row]
        let dataOrgId = data["orgId"]

        if self.feedObjects.contains(dataOrgId!){
            cell.lblDonor.text = "I'm already donating"
        }else{
            print("it's not there")}
        
        cell.lblCharityName.text = data["name"]
        cell.lblDescription.text = data["description"]
        
        return cell
    }
 

}
