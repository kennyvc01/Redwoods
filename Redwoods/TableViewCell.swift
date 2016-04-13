//
//  TableViewCell.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/16/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit
import AVFoundation

class TableViewCell: UITableViewCell {


    
    @IBOutlet weak var movieView:UIView!
    
    @IBOutlet weak var lblCharity: UILabel!
    @IBOutlet weak var lblAmount: UILabel!

    
    var moviePlayer:MPMoviePlayerController!
    var videoURL:NSURL!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //initialize movie player
        moviePlayer = MPMoviePlayerController(contentURL: videoURL)
        
    }
    


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
