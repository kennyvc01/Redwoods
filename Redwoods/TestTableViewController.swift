//
//  TestTableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/12/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import AVKit
import AVFoundation
import MediaPlayer

class TestTableViewController: UITableViewController {
    
    var objects = [[String: String]]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 138, height: 138))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "RedwoodsMasterLogoWhite")
        imageView.image = image
        navigationItem.titleView = imageView
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        self.objects.removeAll()
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
                //if json api/feed returns results then pars json using the parseJSON function
                if json != nil {
                    let json = JSON(data: json!)
                    self.parseJSON(json)
                }
        }
        
        
    }
    
    //function to parse and load JSON results in objects array as ["storyLink","storyTimestamp","description","org"]
    func parseJSON(json: JSON) {
        //loop through json results
        for result1 in json[].arrayValue {
            //loop through json results again to get stories of each org
            for result2 in result1["org"]["stories"].arrayValue{
                let org = result1["org"]["name"].stringValue
                let storyLink  = result2["link"].stringValue
                let storyTimestamp = result2["timestamp"].stringValue
                let description = result2["description"].stringValue
                let amount = result1["amount"].stringValue
                //print(storyLink)
                let obj = ["storyLink": storyLink, "storyTimestamp": storyTimestamp, "description": description, "org": org, "amount": amount]
                objects.append(obj)
            }
        }
        tableView.reloadData()
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
        return self.objects.count
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {

      
        
        
        
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        print("____________________NEW SCROLL____________________")
        
        
        let indexPaths = tableView.indexPathsForVisibleRows
        
        
        
        
        if indexPaths?.count == 1 {
            
            
            print("\(indexPaths![0].row) row 1 ")
            
            
            let cell1:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![0] as NSIndexPath) as! TestTableViewCell
            cell1.titleLabel.text = self.objects[indexPaths![0].row]["org"]
            
            
            var cellRect : CGRect = self.tableView.rectForRowAtIndexPath(indexPaths![0])
            cellRect = self.tableView.superview!.convertRect(cellRect, fromView: self.tableView)
            
            
            if self.tableView.frame.contains(cellRect) {
                
                if cell1.moviePlayer.playbackState == MPMoviePlaybackState.Playing {
                    print("keep playing")
                }else{
                    cell1.videoURL = NSURL(string: self.objects[indexPaths![0].row]["storyLink"]!)!
                    
                    cell1.displayVideo()
                }
                
                
            }
            
            
            
            
        }else if indexPaths?.count == 2 {
            
            
            
            let cell1:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![0] as NSIndexPath) as! TestTableViewCell
            cell1.titleLabel.text = self.objects[indexPaths![0].row]["org"]
            
            let cell2:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![1] as NSIndexPath) as! TestTableViewCell
            cell2.titleLabel.text = self.objects[indexPaths![1].row]["org"]
            
            print("\(indexPaths![0].row) row 1 \(self.objects[indexPaths![0].row]["org"]) \(indexPaths![0])")
            print("\(indexPaths![1].row) row 2 \(self.objects[indexPaths![1].row]["org"]) \(indexPaths![1])")
            
            
            
            var cellRect1 : CGRect = self.tableView.rectForRowAtIndexPath(indexPaths![0])
            cellRect1 = self.tableView.superview!.convertRect(cellRect1, fromView: self.tableView)
            
            var cellRect2 : CGRect = self.tableView.rectForRowAtIndexPath(indexPaths![1])
            cellRect2 = self.tableView.superview!.convertRect(cellRect2, fromView: self.tableView)
            
            
            if self.tableView.frame.contains(cellRect1) {
                
                if cell1.moviePlayer.playbackState == MPMoviePlaybackState.Playing {
                    print("keep playing")
                }else{
                    cell1.videoURL = NSURL(string: self.objects[indexPaths![0].row]["storyLink"]!)!
                    cell1.displayVideo()
                }
                
                
            } else if self.tableView.frame.contains(cellRect2) {
                
                if cell2.moviePlayer.playbackState == MPMoviePlaybackState.Playing {
                    print("keep playing")
                } else {
                    cell2.videoURL = NSURL(string: self.objects[indexPaths![1].row]["storyLink"]!)!
                    cell2.displayVideo()
                    
                }
                
            }
            
            
            
        } else if indexPaths?.count > 2 {
            
            
            let cell1:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![0] as NSIndexPath) as! TestTableViewCell
            cell1.titleLabel.text = self.objects[indexPaths![0].row]["org"]
            
            
            let cell2:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![1] as NSIndexPath) as! TestTableViewCell
            cell2.titleLabel.text = self.objects[indexPaths![1].row]["org"]
            
            
            let cell3:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![2] as NSIndexPath) as! TestTableViewCell
            cell3.titleLabel.text = self.objects[indexPaths![2].row]["org"]
            
            
            print("\(indexPaths![0].row) row 1 \(self.objects[indexPaths![0].row]["org"]) \(indexPaths![0])")
            print("\(indexPaths![1].row) row 2 \(self.objects[indexPaths![1].row]["org"]) \(indexPaths![1])")
            print("\(indexPaths![2].row) row 3 \(self.objects[indexPaths![2].row]["org"]) \(indexPaths![2])")
            
            
            
            var cellRect1 : CGRect = self.tableView.rectForRowAtIndexPath(indexPaths![0])
            cellRect1 = self.tableView.superview!.convertRect(cellRect1, fromView: self.tableView)
            
            var cellRect2 : CGRect = self.tableView.rectForRowAtIndexPath(indexPaths![1])
            cellRect2 = self.tableView.superview!.convertRect(cellRect2, fromView: self.tableView)
            
            var cellRect3 : CGRect = self.tableView.rectForRowAtIndexPath(indexPaths![2])
            cellRect3 = self.tableView.superview!.convertRect(cellRect3, fromView: self.tableView)
            
            
            if self.tableView.frame.contains(cellRect1) {
                
                if cell1.moviePlayer.playbackState == MPMoviePlaybackState.Playing {
                    print("keep playing")
                }else{
                    cell1.videoURL = NSURL(string: self.objects[indexPaths![0].row]["storyLink"]!)!
                    cell1.displayVideo()
                }
                
            } else if self.tableView.frame.contains(cellRect2) {
                
                if cell2.moviePlayer.playbackState == MPMoviePlaybackState.Playing {
                    print("keep playing")
                } else {
                    cell2.videoURL = NSURL(string: self.objects[indexPaths![1].row]["storyLink"]!)!
                    cell2.displayVideo()
                    
                }
                
            } else if self.tableView.frame.contains(cellRect2) {
                if cell3.moviePlayer.playbackState == MPMoviePlaybackState.Playing {
                    print("keep playing")
                } else {
                    cell3.videoURL = NSURL(string: self.objects[indexPaths![2].row]["storyLink"]!)!
                    cell3.displayVideo()
                    
                }
            }
            
            
            
        }
        
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

        

    }
    
    
    //populate each cell based on index path of array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TestTableViewCell
        
        
        
        return cell
    }
    
    
    
    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TestTableViewCell
        
        if self.objects.count > 1{
            cell.moviePlayer.stop()
        }
        
    }
    


}
