//
//  TestVideoTableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/4/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVKit
import AVFoundation
import MediaPlayer



class TestVideoTableViewController: UITableViewController {
    
    var objects = [[String: String]]()
    var moviePlayer = MPMoviePlayerController()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    override func viewDidAppear(animated: Bool) {
        
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
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.objects.count
    }

    
    //populate each cell based on index path of array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TestVideoTableViewCell
        
        
       
        
        
        let url:NSURL = NSURL(string: self.objects[indexPath.row]["storyLink"]!)!
        
        moviePlayer.stop()
        moviePlayer = MPMoviePlayerController(contentURL: url)
        moviePlayer.controlStyle = MPMovieControlStyle.None
        moviePlayer.scalingMode = MPMovieScalingMode.AspectFill
        moviePlayer.movieSourceType = MPMovieSourceType.File
        moviePlayer.repeatMode = MPMovieRepeatMode.One
        moviePlayer.initialPlaybackTime = -1.0
        moviePlayer.view.frame = cell.vwVideo.bounds

        //moviePlayer.view.center = CGPointMake(CGRectGetMidX(cell.vwVideo.bounds), CGRectGetMidY(cell.vwVideo.bounds))
        cell.vwVideo.addSubview(moviePlayer.view)
       // moviePlayer.prepareToPlay()
        moviePlayer.play()
        

        
        
        return cell
    }
    
}
