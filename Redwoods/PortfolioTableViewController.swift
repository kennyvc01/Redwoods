//
//  PortfolioTableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/31/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Moya
import Moya_ObjectMapper


class PortfolioTableViewController: UITableViewController {

    
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
    var profile: [Profile] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var portfolio: [Portfolio] {
        var _Portfolio = [Portfolio]()
        for profile in self.profile {
            _Portfolio.appendContentsOf(profile.portfolio.map({ (_profile) -> Portfolio in
                _profile.profile = profile
                return _profile
            }))
        }
        return _Portfolio
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {

        provider.requestArray(.Profile, succeed: { (profiles: [Profile]) in
            self.profile = profiles
        }) { (error) in
            self.error = error
            print(error)
        }
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
        return self.portfolio.count
    }
    
    
    
    //populate each cell based on index path of array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PortfolioTableViewCell
        cell.lblCharityName.text = self.portfolio[indexPath.row].name
        cell.lblDonationDay.text = "Collection Day: " + String(self.portfolio[indexPath.row].paymentDay)
        cell.lblDonationAmount.text = "Monthly Donation Amount: $" + String(self.portfolio[indexPath.row].amount)
        
//        cell.lblCharityName.text = self.objects[indexPath.row]["org"]! as String
//        cell .lblDonationAmount.text = "Monthly Donation Amount: $" + self.objects[indexPath.row]["amount"]! as String
//        cell .lblDonationDay.text = "Collection Day: " + self.objects[indexPath.row]["paymentDate"]! as String
        
        

        return cell
    }
    
    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Segue" {
            
            let evc = segue.destinationViewController as! EditDonationViewController
            
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
            let data = self.portfolio[indexPath.row]
            
            evc.CharityLabel = data.name
            evc.orgId = data.orgId
            evc.amount = String(data.amount)
            evc.paymentDate = String(data.paymentDay)
        }
    }

    

}
