//
//  CharitySearchTableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/26/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

//Used in initial registration

import UIKit
import Moya
import Moya_ObjectMapper
import Haneke

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
//        
//        orgs = []
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

        
        return cell
    }
    
    //MARK: - Table view delegate 

 
    
    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Segue" {
            let dvc = segue.destinationViewController as! DonationViewController
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
            let data = orgs[indexPath.row]
            
            dvc.CharityLabel = data.name!
            dvc.orgId = data.id!
            dvc.introUrl = data.introURL!

        }
    }

}
