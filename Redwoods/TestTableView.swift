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

    var objects = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        var cells = self.tableView.visibleCells
        var indexPaths = self.tableView.indexPathsForVisibleRows!

        
        if (cells.count == 1) {
            self.checkVisibilityOfCell(cells[0] as! TestTableViewCell, forIndexPath: indexPaths[0] )
        } else if (cells.count == 2) {
            self.checkVisibilityOfCell(cells[1] as! TestTableViewCell, forIndexPath: indexPaths[1] )
        }else if (cells.count == 3) {
            self.checkVisibilityOfCell(cells[2] as! TestTableViewCell, forIndexPath: indexPaths[2])
        }

    }
    
    //populate each cell based on index path of array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TestTableViewCell
//        print(indexPath.row)
//        print(cell.completelyVisible)
        
        cell.lblCharity.text = self.objects[indexPath.row]["org"]! as String
        cell .lblAmount.text = "Your " + self.objects[indexPath.row]["amount"]! as String + " dollars a month is doing this!"
        
        if cell.completelyVisible == true {

            let url:NSURL = NSURL(string: self.objects[indexPath.row]["storyLink"]!)!
                //let url:NSURL = NSURL(string: "https://s3.amazonaws.com/redwoods-stories/Berea.mp4")!
                    cell.moviePlayer = MPMoviePlayerController(contentURL: url)
                    cell.moviePlayer.controlStyle = MPMovieControlStyle.None
                    cell.moviePlayer.scalingMode = MPMovieScalingMode.AspectFill
                    cell.moviePlayer.movieSourceType = MPMovieSourceType.File
                    cell.moviePlayer.repeatMode = MPMovieRepeatMode.One
                    cell.moviePlayer.initialPlaybackTime = -1.0
                    cell.moviePlayer.prepareToPlay()
                    cell.moviePlayer.play()

            
        
        }
        else {
           
        }
        

        

        return cell
    }
    
    func checkVisibilityOfCell(cell : TestTableViewCell, forIndexPath : NSIndexPath){
        
        
//        var cellRect : CGRect = self.tableView.rectForRowAtIndexPath(forIndexPath)
//        print(cellRect)
//        
//        cellRect = self.tableView.superview!.convertRect(cellRect, fromView: self.tableView)
//
//        let completelyVisible : Bool = self.tableView.frame.contains(cellRect)
//        cell.completelyVisible = completelyVisible
        

    }
    


    
    

}
