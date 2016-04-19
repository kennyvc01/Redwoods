//
//  TableViewController.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/16/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // logo in navbar
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 138, height: 138))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "RedwoodsMasterLogoWhite")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        provider.requestArray(.Feed, succeed: { (organizations: [Organization]) in
            self.orgs = organizations
        }) { (error) in
            self.error = error
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        orgs = []
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.stories.count
    }
    
    
    //populate each cell based on index path of array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell

        cell.shouldPlay = indexPath.row == 0
        cell.story = stories[indexPath.row]

        
//        let videoURL: NSURL = NSBundle.mainBundle().URLForResource("Berea", withExtension: "mp4")!
//
//        cell.movieView.play(videoURL)

        return cell
    }
    
    // MARK: UITableViewDelegate

    
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

//        for indexPath in tableView.indexPathsForVisibleRows ?? [] {
//            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
//
//                tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
//                
//                
//            }
//        }
        
//        for (i, )cell) in tableView.visibleCells as! [TableViewCell] {
//            
//            let frame = cell.movieView.frame
//            let point = cell.convertPoint(frame.origin, toView: nil)
//            if (point.y + frame.height) <= view.frame.height {
//                cell.movieView.playerLayer.player!.play()
//            }
//        }
        
//        for (i, indexPath) in tableView.indexPathsForVisibleRows!.enumerate() {
//            if let cell = tableView.cellForRowAtIndexPath(indexPath) as? TableViewCell {
//                var rect = tableView.rectForRowAtIndexPath(indexPath)
//                rect = tableView.superview!.convertRect(rect, fromView: tableView)
//                //print("Rect for \(indexPath): \(rect)")
//                // tableview height = 672
//                // superview height = 736
//                
//                // movieView height = 532
//                
//                if i == 1 && rect.origin.y <= (tableView.superview!.frame.height - cell.frame.height + 36) {
//                    if cell.movieView.playing != true {
//                        cell.movieView.playing = true
//                        cell.movieView.playerLayer.player?.play()
//                    }
//                } else {
//                    cell.movieView.pause()
//                    if let _cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: indexPath.row - 1, inSection: 0)) as? TableViewCell where indexPath.row > 0 {
//                        _cell.movieView.playerLayer.player?.play()
//                    }
//                }
//                
////                if rect.origin.y < 400 && rect.origin.y > -132 {
////                    if cell.movieView.playing == true {
////                        
////                    }else{
////                        cell.movieView.playing = true
////                        cell.movieView.playerLayer.player?.play()
////                    }
////                }else {
////                    cell.movieView.pause()
////                    
////                }
//
//                
//                
//                
//                // Rect for <NSIndexPath: 0xc000000000200016> {length = 2, path = 0 - 1}: (0.0, 241.333333333333, 414.0, 532.0)
//            }
//        }
//        
        
        for indexPath in tableView.indexPathsForVisibleRows ?? [] {
            if let cell : TableViewCell = tableView.cellForRowAtIndexPath(indexPath)! as? TableViewCell {
                            var cellRect : CGRect = self.tableView.rectForRowAtIndexPath(indexPath)
                            cellRect = self.tableView.superview!.convertRect(cellRect, fromView: self.tableView)
        
                        if cellRect.origin.y < 400 && cellRect.origin.y > -132 {
                            if cell.movieView.playing == true {
        
                            }else{
                                cell.movieView.playing = true
                                cell.movieView.playerLayer.player?.play()
                            }
                        }else {
                            cell.movieView.pause()
                            
                        }
        
        
        
            }
        }
    }
    
//// This will only be called on load of the table view data and when the cell has been off screen and is about to come onto screen.
    
//    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        if let _cell = cell as? TableViewCell {
            
            
            //_cell.shouldPlay = true
//            var cellRect : CGRect = self.tableView.rectForRowAtIndexPath(indexPath)
//            cellRect = self.tableView.superview!.convertRect(cellRect, fromView: self.tableView)
//            if cellRect.origin.y < 400 && cellRect.origin.y > -132 {
//                if _cell.movieView.playing == true {
//                   
//                }else{
//                    _cell.movieView.playing = true
//                    _cell.movieView.playerLayer.player?.play()
//                //    _cell.shouldPlay = true
//                }
//            }else {
//                _cell.movieView.pause()
//                
//            }
            

//        }
  //  }
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
