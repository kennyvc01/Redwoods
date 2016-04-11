//
//  ActivityTableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/16/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit




class ActivityTableViewController: UITableViewController {
    
    var ActivityObjects1: NSMutableArray! = NSMutableArray()
    var ActivityObjects2: NSMutableArray! = NSMutableArray()
    var ActivityObjects3: NSMutableArray! = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Load activity object arrays
        self.ActivityObjects1.addObject("10/04/2016")
        self.ActivityObjects1.addObject("10/04/2016")
        self.ActivityObjects1.addObject("09/04/2016")
        
        self.ActivityObjects2.addObject("20.00")
        self.ActivityObjects2.addObject("12.00")
        self.ActivityObjects2.addObject("20.00")
      
        self.ActivityObjects3.addObject("Laura's Home")
        self.ActivityObjects3.addObject("Berea Children's Home")
        self.ActivityObjects3.addObject("Preston's H.O.P.E.")


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //Number of table view sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    //Number of table view rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.ActivityObjects1.count
    }

    //Populate table view cell from arrays
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath) as! ActivityTableViewCell
        
        cell.LblActivityLabel1.text = self.ActivityObjects1.objectAtIndex(indexPath.row) as? String
        cell.LblActivityLabel2.text = self.ActivityObjects2.objectAtIndex(indexPath.row) as? String
        cell.LblActivityLabel3.text = self.ActivityObjects3.objectAtIndex(indexPath.row) as? String

        return cell
        
    }
    
    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TransactionSegue" {
                
                let svc = segue.destinationViewController as! TransactionViewController
                
                let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
                
                svc.TransactionLabel1 = self.ActivityObjects1[indexPath.row] as! String
                svc.TransactionLabel2 = "Donated $" + (self.ActivityObjects2[indexPath.row] as! String) 
                svc.TransactionLabel3 = self.ActivityObjects3[indexPath.row] as! String
            }
    }
    


}
