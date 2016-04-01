//
//  TestTableView.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/29/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVKit
import AVFoundation
import MediaPlayer

class TestTableView: UITableViewController {

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
        self.videoArray.addObject("LaurasHome")
        self.videoArray.addObject("Berea")
        self.videoArray.addObject("LaurasHome")
        self.videoArray.addObject("LaurasHome")
        self.videoArray.addObject("Berea")
        self.videoArray.addObject("LaurasHome")
        self.videoArray.addObject("LaurasHome")
        self.videoArray.addObject("Berea")
        self.videoArray.addObject("LaurasHome")
        self.videoArray.addObject("LaurasHome")
        self.videoArray.addObject("Berea")
        self.videoArray.addObject("LaurasHome")
        
        print (self.videoArray)
        print (self.videoArray.count)
        
        
        //        self.image.addObject(UIImage(named: "Image1.png")!)
        //        self.image.addObject(UIImage(named: "Image2.png")!)
        //        self.image.addObject(UIImage(named: "Image3.png")!)
        
        
        
        self.tableView.reloadData()
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
        return self.videoArray.count
    }
    
    
    
    //populate each cell based on index path of array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TestTableViewCell
        

        let path = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(self.videoArray.objectAtIndex(indexPath.row) as? String, ofType:"mp4")!)
        
        cell.moviePlayer = MPMoviePlayerController(contentURL: path)
        cell.moviePlayer.controlStyle = MPMovieControlStyle.None
        cell.moviePlayer.scalingMode = MPMovieScalingMode.AspectFill
        cell.moviePlayer.movieSourceType = MPMovieSourceType.File
        cell.moviePlayer.repeatMode = MPMovieRepeatMode.One
        cell.moviePlayer.initialPlaybackTime = -1.0
        cell.moviePlayer.prepareToPlay()
        cell.moviePlayer.play()
                
        
//        let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(self.videoArray.objectAtIndex(indexPath.row) as? String, ofType:"mp4")!)
//        let player = AVPlayer(URL: url)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        
//
//        
//        player.play()
        
    
        
        
        
        
        
        
        return cell
    }
    
    

}
