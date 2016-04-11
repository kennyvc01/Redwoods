//
//  TableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/16/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVKit
import AVFoundation
import MediaPlayer


class TableViewController: UITableViewController {
    
    var objects = [[String: String]]()
 
    var moviePlayer:MPMoviePlayerController!
    var videoURL:NSURL!



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
        moviePlayer.stop()
        self.tableView.reloadData()
    }
    
   override func scrollViewDidScroll(scrollView: UIScrollView) {
        
    

    }
    
    
    //populate each cell based on index path of array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell

        
        cell.lblCharity.text = self.objects[indexPath.row]["org"]! as String
        cell .lblAmount.text = "Your " + self.objects[indexPath.row]["amount"]! as String + " dollars a month is doing this!"
        
        
        let url:NSURL = NSURL(string: self.objects[indexPath.row]["storyLink"]!)!
        
        
        
        
        var cellRect : CGRect = self.tableView.rectForRowAtIndexPath(indexPath)
        cellRect = self.tableView.superview!.convertRect(cellRect, fromView: self.tableView)

        
        if self.tableView.frame.contains(cellRect) {
        
                moviePlayer = MPMoviePlayerController(contentURL: url)
                moviePlayer.controlStyle = MPMovieControlStyle.None
                moviePlayer.scalingMode = MPMovieScalingMode.AspectFill
                moviePlayer.movieSourceType = MPMovieSourceType.File
                moviePlayer.repeatMode = MPMovieRepeatMode.One
                moviePlayer.initialPlaybackTime = -1.0
                moviePlayer.view.frame = cell.movieView.bounds
                moviePlayer.view.center = CGPointMake(CGRectGetMidX(cell.movieView.bounds), CGRectGetMidY(cell.movieView.bounds))
                cell.movieView.addSubview(moviePlayer.view)
                moviePlayer.prepareToPlay()
                moviePlayer.play()
            
            
            
        }else{

        }
    
        
        
        
        return cell
    }


    
    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TableViewCell
        

        
        if self.objects.count > 1{
            moviePlayer.stop()
        }
        
    }


}
