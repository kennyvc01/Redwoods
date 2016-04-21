//
//  CharitySearchTableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/26/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Moya
import Moya_ObjectMapper

class CharitySearchTableViewController: UITableViewController {
    
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
    var objects = [[String: String]]()
    var orgs: [BrowseOrgs] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var feed: [Organization] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
                
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        //BrowseOrgs API request
        provider.requestArray(.BrowseOrgs, succeed: { (organizations: [BrowseOrgs]) in
            self.orgs = organizations
        }) { (error) in
            self.error = error
            print(error)
        }
        //Feed API request
        provider.requestArray(.Feed, succeed: { (organizations: [Organization]) in
            self.feed = organizations
        }) { (error) in
            self.error = error
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        orgs = []
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
        return orgs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CharitySearchTableViewCell
        
        cell.lblCharity.text = orgs[indexPath.row].name
        cell.lblCharityDescription.text = orgs[indexPath.row].description
        cell.txtWebsite.text = orgs[indexPath.row].website
        
        if donating(indexPath) {
            cell.lblDonor.text = "I'm donating"
        }else{
            cell.lblDonor.text = ""
        }
        
        return cell
    }
    
    //MARK: - Table view delegate 
    
    // function to loop through feed to see if user is donating.  Return true if they're donating.
    func donating(indexPath : NSIndexPath) -> Bool {
        var donating : Bool = false
        for _feed in self.feed {
            if _feed.id == orgs[indexPath.row].id{
                donating = true
            }
        }
       return donating
    }
 
    
    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Segue" {
            let dvc = segue.destinationViewController as! DonationViewController
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
            let data = orgs[indexPath.row]
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! CharitySearchTableViewCell!;
            
            dvc.CharityLabel = data.name!
            dvc.orgId = data.id!
            dvc.donation = cell.lblDonor.text!
            dvc.introUrl = data.introURL!

        }
    }

}
