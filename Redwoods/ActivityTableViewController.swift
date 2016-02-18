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
        
        self.ActivityObjects1.addObject("10/04/2016")
        self.ActivityObjects1.addObject("10/04/2016")
        self.ActivityObjects1.addObject("09/04/2016")
        
        self.ActivityObjects2.addObject("20.00")
        self.ActivityObjects2.addObject("12.00")
        self.ActivityObjects2.addObject("20.00")
      
        self.ActivityObjects3.addObject("Laura's Home")
        self.ActivityObjects3.addObject("Berea Children's Home")
        self.ActivityObjects3.addObject("Preston's H.O.P.E.")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return self.ActivityObjects1.count
    }

    //Populate table view cell from mutuable array
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
//            if let destination = segue.destinationViewController as? TransactionViewController {
            
//                let path = tableView.indexPathForSelectedRow
//                let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: path!) as! ActivityTableViewCell
//                let res = cell.LblActivityLabel1.text = self.ActivityObjects1.objectAtIndex(path!.row) as? String
//                destination.TransactionLabel1 = (cell.LblActivityLabel1?.text!)!
                
                
                let svc = segue.destinationViewController as! TransactionViewController
                
                let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
                
                svc.TransactionLabel1 = self.ActivityObjects1[indexPath.row] as! String
                svc.TransactionLabel2 = self.ActivityObjects2[indexPath.row] as! String
                svc.TransactionLabel3 = self.ActivityObjects3[indexPath.row] as! String
            }
        }
    
    
    //Execute segue
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        _ = tableView.indexPathForSelectedRow!
        if let _ = tableView.cellForRowAtIndexPath(indexPath) {
            self.performSegueWithIdentifier("TransactionSegue", sender: self)
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
