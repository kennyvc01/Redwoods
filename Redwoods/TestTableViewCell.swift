//
//  TestTableViewCell.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/12/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import MediaPlayer

class TestTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var movieView:UIView! //Set up in storyboard
    
    
    var moviePlayer:MPMoviePlayerController!
    var videoURL:NSURL!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //initialize movie player
        moviePlayer = MPMoviePlayerController(contentURL: videoURL)
        
    }
    
    override func layoutSubviews() {
        //layout movieplayer
        moviePlayer.view.frame = movieView.bounds
        moviePlayer.view.center = CGPointMake(CGRectGetMidX(movieView.bounds), CGRectGetMidY(movieView.bounds))
        movieView.addSubview(moviePlayer.view)
    }
    
    //Action to load video
    func displayVideo() {

        
        
        moviePlayer = MPMoviePlayerController(contentURL: videoURL)
        moviePlayer.controlStyle = MPMovieControlStyle.None
        moviePlayer.scalingMode = MPMovieScalingMode.AspectFill
        moviePlayer.movieSourceType = MPMovieSourceType.File
        moviePlayer.repeatMode = MPMovieRepeatMode.One
        moviePlayer.initialPlaybackTime = -1.0
        moviePlayer.view.frame = movieView.bounds
        moviePlayer.view.center = CGPointMake(CGRectGetMidX(movieView.bounds), CGRectGetMidY(movieView.bounds))
        movieView.addSubview(moviePlayer.view)
        moviePlayer.prepareToPlay()
        moviePlayer.play()
    }

}
