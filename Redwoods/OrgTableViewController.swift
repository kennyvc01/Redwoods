//
//  OrgTableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 5/9/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//


//Used after initial registration


import UIKit

class OrgTableViewController: UITableViewController {
    
    var browseOrgs: [BrowseOrgs] = []
    var feed: [Organization] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.browseOrgs.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! OrgTableViewCell
        
        cell.lblCharity.text = browseOrgs[indexPath.row].name
        cell.lblDescription.text = browseOrgs[indexPath.row].description
        cell.txtWebsite.text = browseOrgs[indexPath.row].website
        
        return cell
    }
    
    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Segue" {
            let dvc = segue.destinationViewController as! DonationViewController
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
            let data = browseOrgs[indexPath.row]
            
            dvc.CharityLabel = data.name!
            dvc.orgId = data.id!
           // dvc.donation = cell.lblDonor.text!
            dvc.introUrl = data.introURL!
            
        }
    }

}
