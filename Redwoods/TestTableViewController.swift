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
    var moviePlayer:MPMoviePlayerController!
    
    
    
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
                let obj = ["storyLink": storyLink, "storyTimestamp": storyTimestamp, "description": description, "org": org, "Amount": amount]
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
    
<<<<<<< HEAD
    
    //populate each cell based on index path of array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TestTableViewCell
        
        cell.lblCharity.text = self.objects[indexPath.row]["org"]
        cell.lblAmount.text = "Your $" + self.objects[indexPath.row]["Amount"]! + " monthly is doing this!"
        
        //cell.movieView.play(NSURL(string: self.objects[indexPath.row]["storyLink"]!)!, autoplay: false)
        //print(objects[indexPath.row])

//        if self.objects[indexPath.row]["storyLink"] != nil{
//            cell.movieView.prepare((NSURL(string: self.objects[indexPath.row]["storyLink"]!))!, autoplay: true, succeed: {
//                print("Asset has been prepared")
//            }) { (error) in
//                print(error)
//            }
//        }

        
=======
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {


>>>>>>> parent of c716e88... Video Feed
        
        
<<<<<<< HEAD
        return cell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        
//        for indexPath in tableView.indexPathsForVisibleRows ?? [] {
//            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
//                tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
//            }
//        }
    }
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        if let _cell = cell as? TestTableViewCell {
//            
//            var cellRect : CGRect = self.tableView.rectForRowAtIndexPath(indexPath)
//            cellRect = self.tableView.superview!.convertRect(cellRect, fromView: self.tableView)
//            
//            if tableView.frame.contains(cellRect) {
//                if _cell.movieView.playing == true {
//                    
//                }else{
//                    _cell.movieView.stop()
//                    _cell.movieView.playing = true
//                    _cell.movieView.playerLayer.player?.play()
//                }
//            }else {
//                _cell.movieView.pause()
//            }
//            
        
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
        //}
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
            let cell1:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![0] as NSIndexPath) as! TestTableViewCell
            let cell2:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![1] as NSIndexPath) as! TestTableViewCell
=======
        let indexPaths = tableView.indexPathsForVisibleRows
        
        if indexPaths?.count == 1 {
            
            
            let cell1:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![0] as NSIndexPath) as! TestTableViewCell
            
                    var cellRect : CGRect = self.tableView.rectForRowAtIndexPath(indexPaths![0])
                    cellRect = self.tableView.superview!.convertRect(cellRect, fromView: self.tableView)
                    let url = NSURL(string: self.objects[indexPaths![0].row]["storyLink"]!)!
                    let player = AVPlayer(URL: url)
                    let playerController = AVPlayerViewController()
            
                    playerController.player = player
                    cell1.movieView.addSubview(playerController.view)
                    if self.tableView.frame.contains(cellRect) {
            
                    playerController.view.frame = cell1.movieView.frame
                    
                        player.play()} else{
                        player.pause()
                    }
            
            
            
        }
            
            
            
            
        else if indexPaths?.count == 2 {
            
            
            
            let cell1:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![0] as NSIndexPath) as! TestTableViewCell
            
            let cell2:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![1] as NSIndexPath) as! TestTableViewCell
            
            
            var cellRect : CGRect = self.tableView.rectForRowAtIndexPath(indexPaths![0])
            cellRect = self.tableView.superview!.convertRect(cellRect, fromView: self.tableView)
            let url = NSURL(string: self.objects[indexPaths![0].row]["storyLink"]!)!
            let player = AVPlayer(URL: url)
            let playerController = AVPlayerViewController()
            
            
            var cellRect2 : CGRect = self.tableView.rectForRowAtIndexPath(indexPaths![1])
            cellRect2 = self.tableView.superview!.convertRect(cellRect2, fromView: self.tableView)
            let url2 = NSURL(string: self.objects[indexPaths![1].row]["storyLink"]!)!
            let player2 = AVPlayer(URL: url2)
            let playerController2 = AVPlayerViewController()
            
            playerController2.player = player2
            cell2.movieView.addSubview(playerController2.view)
            
            playerController.player = player
            cell1.movieView.addSubview(playerController.view)
            
            
            
            
            if self.tableView.frame.contains(cellRect) {
                
                playerController.view.frame = cell1.movieView.frame
                if cell1.playing == "yes"{
                
                }else{
                    player.play()
                    cell1.playing = "yes"
                }
                
                
                
                playerController2.view.frame = cell2.movieView.frame
                
                player2.pause()
                cell2.playing = "no"
                
                
            } else{
                playerController.view.frame = cell1.movieView.frame
                
                player.pause()
                cell1.playing = "no"
                
                if cell2.playing == "yes"{
                
                }else{
                    playerController2.view.frame = cell2.movieView.frame
                    
                    player2.play()
                    cell2.playing = "yes"
                }
                
                
            }
            
            
>>>>>>> parent of c716e88... Video Feed
            
            
            
            
            
        } else if indexPaths?.count > 2 {
            
            
            let cell1:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![0] as NSIndexPath) as! TestTableViewCell
            
            
            let cell2:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![1] as NSIndexPath) as! TestTableViewCell
            
            let cell3:TestTableViewCell = tableView.cellForRowAtIndexPath(indexPaths![2] as NSIndexPath) as! TestTableViewCell
            
            var cellRect : CGRect = self.tableView.rectForRowAtIndexPath(indexPaths![0])
            cellRect = self.tableView.superview!.convertRect(cellRect, fromView: self.tableView)
            let url = NSURL(string: self.objects[indexPaths![0].row]["storyLink"]!)!
            let player = AVPlayer(URL: url)
            let playerController = AVPlayerViewController()
            
            
            var cellRect2 : CGRect = self.tableView.rectForRowAtIndexPath(indexPaths![1])
            cellRect2 = self.tableView.superview!.convertRect(cellRect2, fromView: self.tableView)
            let url2 = NSURL(string: self.objects[indexPaths![1].row]["storyLink"]!)!
            let player2 = AVPlayer(URL: url2)
            let playerController2 = AVPlayerViewController()
            
            var cellRect3 : CGRect = self.tableView.rectForRowAtIndexPath(indexPaths![2])
            cellRect3 = self.tableView.superview!.convertRect(cellRect3, fromView: self.tableView)
            let url3 = NSURL(string: self.objects[indexPaths![2].row]["storyLink"]!)!
            let player3 = AVPlayer(URL: url3)
            let playerController3 = AVPlayerViewController()
            
            playerController.player = player
            cell1.movieView.addSubview(playerController.view)
            
            playerController2.player = player2
            cell2.movieView.addSubview(playerController2.view)

            playerController3.player = player3
            cell2.movieView.addSubview(playerController2.view)

            
            
            
            
            if self.tableView.frame.contains(cellRect) {
                
                playerController.view.frame = cell1.movieView.frame
    
                player.play()
                
                
                playerController2.view.frame = cell2.movieView.frame
                
                player2.pause()
                
                playerController3.view.frame = cell3.movieView.frame
                
                player3.pause()
                
            } else if self.tableView.frame.contains(cellRect2){
                playerController.view.frame = cell1.movieView.frame
                
                player.pause()
                
                playerController2.view.frame = cell2.movieView.frame

                player2.play()
                
                playerController3.view.frame = cell3.movieView.frame
                
                player3.pause()
            } else if self.tableView.frame.contains(cellRect3) {
                playerController.view.frame = cell1.movieView.frame
                
                player.pause()
                
                playerController2.view.frame = cell2.movieView.frame
                
                player2.pause()
                
                playerController3.view.frame = cell3.movieView.frame
     
                player3.play()
            }
            
        }
        
        
        
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {

            self.tableView.reloadData()
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        
        
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TestTableViewCell
    }
    
    //populate each cell based on index path of array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TestTableViewCell

//        //#1
//        
//        let path: String = self.objects[indexPath.row]["storyLink"]!
//        let movieurl: NSURL = NSURL.fileURLWithPath(path)
//        let movie : AVPlayerViewController = AVPlayerViewController()
//        
//        movie.view.frame = cell.movieView.bounds
//        
//        let player: AVPlayer = AVPlayer(URL: movieurl)
//        movie.player? = player
//        
//        cell.movieView.addSubview(movie.view)
//        player.play()
        
        
        
//        
//        //#2
//        let url = NSURL(string:
//            objects[indexPath.row]["storyLink"]!)
//        let player = AVPlayer(URL: url!)
//        let playerController = AVPlayerViewController()
//        
//        playerController.player = player
//        self.addChildViewController(playerController)
//        cell.movieView.addSubview(playerController.view)
//        playerController.view.frame = self.view.frame
//        
//        player.play()
        
        //#3
        
//        var cellRect : CGRect = self.tableView.rectForRowAtIndexPath(indexPath)
//        cellRect = self.tableView.superview!.convertRect(cellRect, fromView: self.tableView)
//        let url = NSURL(string:
//            self.objects[indexPath.row]["storyLink"]!)
//        let player = AVPlayer(URL: url!)
//        let playerController = AVPlayerViewController()
//        
//        playerController.player = player
//        // cell.addChildViewController(playerController)
//        cell.movieView.addSubview(playerController.view)
//        if self.tableView.frame.contains(cellRect) {
//        
//        playerController.view.frame = cell.movieView.frame
//        
//            player.play()} else{
//            player.pause()
//        }
//        

        
        return cell
    }
    
    

    
    
    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    }
    


}
