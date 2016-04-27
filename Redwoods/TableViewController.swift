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
    //moya provider
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
    //organization model
    var orgs: [Organization] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    //map stories array for each org
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
        
//        // logo in navbar
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 138, height: 138))
//        imageView.contentMode = .ScaleAspectFit
//        let image = UIImage(named: "RedwoodsMasterLogoWhite")
//        imageView.image = image
//        navigationItem.titleView = imageView
        
        let attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "Noteworthy", size: 30)!
        ]
        self.title = "Redwoods"
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //Moya request array and map to Organization model
        provider.requestArray(.Feed, succeed: { (organizations: [Organization]) in
            self.orgs = organizations
        }) { (error) in
            self.error = error
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //orgs = []
    }
    
    // MARK: - TABLE VIEW DATASOURCE
 
    //Number of table view sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    //Number of table view rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if stories.count > 0 {
            return self.stories.count
        } else {
            return 1
        }
        
        
    }
    
    
    //populate each cell based on index path of array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell

        if stories.count > 0 {
            if indexPath.row == 1 {
                cell.indexPath = indexPath.row
            }
            cell.story = stories[indexPath.row]
            
            //        let videoURL: NSURL = NSBundle.mainBundle().URLForResource("Berea", withExtension: "mp4")!
            //        cell.movieView.play(videoURL)
            
            
        } else {
            
        }
        return cell
    }

    // MARK: - TABLEVIEW DELEGATE
    
    override func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        
//        let indexPaths = tableView.indexPathsForVisibleRows
//        
//        let actualPosition = scrollView.panGestureRecognizer.translationInView(scrollView.superview)
//        if (actualPosition.y > 0){
//            
//            //check if it's the first index path.  if it is don't scroll up
//            for index in indexPaths! {
//                if index.row != 0 {
//                    //scroll up
//                    tableView.scrollToRowAtIndexPath(indexPaths![0], atScrollPosition: .Top, animated: true)
//                }
//            }
//        }else {
//            //check if it's the last index path.  if it is don't scroll down
//            for index in indexPaths! {
//                if index.row < self.stories.count-1 {
//                    //scroll down
//                    tableView.scrollToRowAtIndexPath(indexPaths![1], atScrollPosition: .Bottom, animated: true)
//                }
//            }
//        }
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
            
            var cellRect : CGRect = self.tableView.rectForRowAtIndexPath(indexPath)
            cellRect = self.tableView.superview!.convertRect(cellRect, fromView: self.tableView)
            if cellRect.origin.y < 400 && cellRect.origin.y > -132 {
                if _cell.movieView.playing == true {
                }else{
                    _cell.movieView.playing = true
                    _cell.movieView.playerLayer.player?.play()
                }
            }else {
                _cell.movieView.pause()
            }
        }
    }
    

    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        for indexPath in tableView.indexPathsForVisibleRows ?? [] {
            if let cell : TableViewCell = tableView.cellForRowAtIndexPath(indexPath) as? TableViewCell {
                if cell.movieView.playing {
                    cell.movieView.stop()
                    cell.movieView.playerLayer.player = nil
                }
            }
        }

    }
}
