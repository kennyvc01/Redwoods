//
//  Test2.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/29/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit

import AVKit
import AVFoundation
import MediaPlayer


class Test2: UIViewController {
    
    var browseOrgobjects = [[String: String]]()
    var feedObjects = [[String: String]]()

    
    @IBOutlet weak var vwWebView: UIWebView!
    
    
    var moviePlayer:MPMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url:NSURL = NSURL(string: "https://s3.amazonaws.com/redwoods-stories/Berea.mp4")!
        
        moviePlayer = MPMoviePlayerController(contentURL: url)
        
        moviePlayer.view.frame = CGRect(x: 20, y: 100, width: 200, height: 150)
        
        self.view.addSubview(moviePlayer.view)
        
        moviePlayer.fullscreen = true
        
        moviePlayer.controlStyle = MPMovieControlStyle.Embedded
        
    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        
//       // https://s3.amazonaws.com/redwoods-stories/Berea.mp4
//        
//        
//        let path = fileURLWithPath: "https://s3.amazonaws.com/redwoods-stories/Berea.mp4"
//        let moviePlayer = MPMoviePlayerController(contentURL: path)
//        moviePlayer.controlStyle = MPMovieControlStyle.None
//        moviePlayer.scalingMode = MPMovieScalingMode.AspectFill
//        moviePlayer.movieSourceType = MPMovieSourceType.File
//        moviePlayer.repeatMode = MPMovieRepeatMode.One
//        moviePlayer.initialPlaybackTime = -1.0
//        moviePlayer.prepareToPlay()
//        moviePlayer.play()
//
//        
//    }
    
    override func viewDidAppear(animated: Bool) {
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
