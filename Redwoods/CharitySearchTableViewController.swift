//
//  CharitySearchTableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/26/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit

class CharitySearchTableViewController: UITableViewController {

    var objects: NSMutableArray! = NSMutableArray()
    var summary: NSMutableArray! = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //load objects
        self.objects.addObject("Laura's Home")
        self.objects.addObject("Berea Children's Home")
        self.objects.addObject("Preston's H.O.P.E.")
        
        //load objects
        self.summary.addObject("For women and children, we are a bridge from crisis to stability and self-sufficiency. At Laura’s Home, our 3-phase, program offers an array of services geared at preparing women and children for positive, productive futures.")
        self.summary.addObject("For 142 years, Berea Children's Home and Family Services has been aleader in Northeast Ohio in providing effective mental health and socialservices to children and families.")
        self.summary.addObject("The Inspiration for Preston's H.O.P.E. came from very special friends and family of a little boy born with Spinal Muscular Atrophy (SMA).  They believed that if his dreams were to play in a park with all other kids, then there must be many, many other children with the same dream as well.")
        
        self.tableView.reloadData()
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 55.0/255.0, green: 55.0/255.0, blue: 55.0/255.0, alpha: 1.0);
        self.navigationController!.navigationBar.tintColor = UIColor(red: 76.0/255.0, green: 288.0/255.0, blue: 144.0/255.0, alpha: 1.0);
         self.navigationController!.navigationBar.tintColor = UIColor(red: 76.0/255.0, green: 288.0/255.0, blue: 144.0/255.0, alpha: 1.0);
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]

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
        
        cell.lblCharity.text = self.objects.objectAtIndex(indexPath.row) as? String
        cell.lblCharityDescription.text = self.summary.objectAtIndex(indexPath.row) as? String


        return cell
    }
    
    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Segue" {
            
            let dvc = segue.destinationViewController as! DonationViewController
            
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
            
            dvc.CharityLabel = self.objects[indexPath.row] as! String

        }
    }



    

}
