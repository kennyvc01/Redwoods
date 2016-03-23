//
//  TableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/16/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class TableViewController: UITableViewController {
    
    var objects: NSMutableArray! = NSMutableArray()
    //var image: NSMutableArray! = NSMutableArray()
    var videoArray: NSMutableArray! = NSMutableArray()




    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        //load objects and image arrays
        self.objects.addObject("Laura's Home")
        self.objects.addObject("Berea Children's Home")
        self.objects.addObject("Preston's H.O.P.E.")
        
        self.videoArray.addObject("LaurasHome")
        self.videoArray.addObject("Berea")
        self.videoArray.addObject("LaurasHome")
        
      
//        self.image.addObject(UIImage(named: "Image1.png")!)
//        self.image.addObject(UIImage(named: "Image2.png")!)
//        self.image.addObject(UIImage(named: "Image3.png")!)
        

        
        self.tableView.reloadData()
        UINavigationBar.appearance().barTintColor = UIColor(red: 55.0/255.0, green: 55.0/255.0, blue: 55.0/255.0, alpha: 1.0);
        self.navigationController!.navigationBar.tintColor = UIColor(red: 76.0/255.0, green: 288.0/255.0, blue: 144.0/255.0, alpha: 1.0);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }

    
    
    
    
    
    

    // MARK: - Table view data source

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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        cell.LblBranch.text = self.objects.objectAtIndex(indexPath.row) as? String
        
             
        
        
        
               let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(self.videoArray.objectAtIndex(indexPath.row) as? String, ofType:"mp4")!)
                let player = AVPlayer(URL: url)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
        
        
                playerViewController.view.frame = CGRectMake(1, 1, 395, 500)
                cell.addSubview(playerViewController.view)

        
//        
//        let url = NSURL(fileURLWithPath: self.videoArray.objectAtIndex(indexPath.row) as! String)
//        let player = AVPlayer(URL: url)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        
//        
//        playerViewController.view.frame = CGRectMake(1, 1, 395, 500)
//        cell.addSubview(playerViewController.view)
        
       
        //player.play()

        
//        cell.ImgBranch.image = self.image.objectAtIndex(indexPath.row) as? UIImage
        

        return cell
    }
    



}
