//
//  TableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/16/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
//import Alamofire
//import SwiftyJSON
import Moya
import Moya_ObjectMapper
import AVKit
import AVFoundation


class TableViewController: UITableViewController {
    
    // DZNEmptyDataSet
    
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
    var objects = [[String: String]]()
    var orgs: [Organization] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var stories: [Story] {
        var _stories = [Story]()
        for org in orgs {
            _stories.appendContentsOf(org.stories.map({ (story) -> Story in
                story.organization = org
                return story
            }))
        }
        return _stories
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // logo in navbar
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 138, height: 138))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "RedwoodsMasterLogoWhite")
        imageView.image = image
        navigationItem.titleView = imageView
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
//        self.objects.removeAll()
//        //set username and password = key chain
//        let user: String = KeychainWrapper.stringForKey("username")!
//        let password: String = KeychainWrapper.stringForKey("password")!
//        
//        //Credentials for basic authentication using text fields for username and password
//        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
//        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
//        let headers = ["Authorization": "Basic \(base64Credentials)"]
//        
        provider.requestArray(.Feed, succeed: { (organizations: [Organization]) in
            self.orgs = organizations
        }) { (error) in
            self.error = error
            print(error)
        }
        
        //GET Method for api/feed
//        Alamofire.request(.GET, "https://redwoods-engine-test.herokuapp.com/api/feed", headers: headers)
//            .response { (request, response, json, error) in
//                //if json api/feed returns results then pars json using the parseJSON function
//                if json != nil {
//                    let json = JSON(data: json!)
//                    self.parseJSON(json)
//                }
//        }
        
        
    }
    
    //function to parse and load JSON results in objects array as ["storyLink","storyTimestamp","description","org"]
//    func parseJSON(json: JSON) {
//        //loop through json results
//        for result1 in json[].arrayValue {
//            //loop through json results again to get stories of each org
//            for result2 in result1["org"]["stories"].arrayValue{
//                let org = result1["org"]["name"].stringValue
//                let storyLink  = result2["link"].stringValue
//                let storyTimestamp = result2["timestamp"].stringValue
//                let description = result2["description"].stringValue
//                let amount = result1["amount"].stringValue
//                //print(storyLink)
//                let obj = ["storyLink": storyLink, "storyTimestamp": storyTimestamp, "description": description, "org": org, "Amount": amount]
//                objects.append(obj)
//  
//            }
//        }
//        tableView.reloadData()
//        
//       
//    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        orgs = []
    }
    
    
    //Number of table view sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    //Number of table view rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.stories.count
    }
    
    
    //populate each cell based on index path of array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
//        cell.story = stories[indexPath.row]
//        print(stories[indexPath.row])
        if indexPath.row == 1 {
            cell.indexPath = indexPath.row
        }
            cell.story = stories[indexPath.row]

        
//        let videoURL: NSURL = NSBundle.mainBundle().URLForResource("Berea", withExtension: "mp4")!
//
//        cell.movieView.play(videoURL)

        return cell
    }

    
    override func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        
        let indexPaths = tableView.indexPathsForVisibleRows
        
        let actualPosition = scrollView.panGestureRecognizer.translationInView(scrollView.superview)
        if (actualPosition.y > 0){
            
            //scroll up
            tableView.scrollToRowAtIndexPath(indexPaths![0], atScrollPosition: .Top, animated: true)

        }else{
            
            //scroll down
            tableView.scrollToRowAtIndexPath(indexPaths![1], atScrollPosition: .Bottom, animated: true)
        }

        

    }
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {

        for indexPath in tableView.indexPathsForVisibleRows ?? [] {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {

                tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
                
                
            }
        }

    }
        
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let _cell = cell as? TableViewCell {
            
            
            //_cell.shouldPlay = true
            var cellRect : CGRect = self.tableView.rectForRowAtIndexPath(indexPath)
            cellRect = self.tableView.superview!.convertRect(cellRect, fromView: self.tableView)
            if cellRect.origin.y < 400 && cellRect.origin.y > -132 {
                if _cell.movieView.playing == true {
                   
                }else{
                    _cell.movieView.playing = true
                    _cell.movieView.playerLayer.player?.play()
                //    _cell.shouldPlay = true
                }
            }else {
                _cell.movieView.pause()
                
            }
            

//
//            //DONT MODIFY
//            
//            if tableView.frame.contains(cell.frame) && !_cell.movieView.playing {
//                _cell.movieView.playing = true
//                _cell.movieView.playerLayer.player!.play()
//                print("Did play video at indexpath")
//                return
//            } else if _cell.movieView.playing {
//                _cell.movieView.pause()
//                print("Did pause video at indexpath")
//            }
        }
    }
//
//    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        if let _cell = cell as? TableViewCell {
//            _cell.movieView.stop()
//            print("Did stop video at indexpath: \(indexPath)")
//
//        }
//    }
    

    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        
        let indexPaths = tableView.indexPathsForVisibleRows
        if indexPaths?.count == 2 {
            let cell1:TableViewCell = tableView.cellForRowAtIndexPath(indexPaths![0] as NSIndexPath) as! TableViewCell
            let cell2:TableViewCell = tableView.cellForRowAtIndexPath(indexPaths![1] as NSIndexPath) as! TableViewCell
            
            cell1.movieView.playerLayer.player = nil
            cell2.movieView.playerLayer.player = nil
        } else if indexPaths?.count == 3 {
            let cell1:TableViewCell = tableView.cellForRowAtIndexPath(indexPaths![0] as NSIndexPath) as! TableViewCell
            let cell2:TableViewCell = tableView.cellForRowAtIndexPath(indexPaths![1] as NSIndexPath) as! TableViewCell
            let cell3:TableViewCell = tableView.cellForRowAtIndexPath(indexPaths![2] as NSIndexPath) as! TableViewCell
            
            cell1.movieView.playerLayer.player = nil
            cell2.movieView.playerLayer.player = nil
            cell3.movieView.playerLayer.player = nil
        }
        
     
        
    }


}
