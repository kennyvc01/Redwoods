//
//  TestTableViewCell.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/12/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit
import AVFoundation

class TestTableViewCell: UITableViewCell {

    @IBOutlet weak var movieView:UIView!
    
    @IBOutlet weak var lblCharity: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    
<<<<<<< HEAD
    var videoURL: NSURL! 

    var shouldPlay = false
    

=======
    var moviePlayer:AVPlayerViewController!
    var videoUrl = ""
    var visible = "true"
    var playing = ""
>>>>>>> parent of c716e88... Video Feed
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //initialize movie player
        
        
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {

        
        
    }
    
    //Action to load video
<<<<<<< HEAD
    //    func displayVideo() {
    //
    //        moviePlayer = MPMoviePlayerController(contentURL: videoURL)
    //        moviePlayer.controlStyle = MPMovieControlStyle.None
    //        moviePlayer.scalingMode = MPMovieScalingMode.Fill
    //        moviePlayer.movieSourceType = MPMovieSourceType.File
    //        moviePlayer.repeatMode = MPMovieRepeatMode.One
    //        moviePlayer.initialPlaybackTime = -1.0
    //        moviePlayer.view.frame = movieView.bounds
    //        moviePlayer.view.center = CGPointMake(CGRectGetMidX(movieView.bounds), CGRectGetMidY(movieView.bounds))
    //        movieView.addSubview(moviePlayer.view)
    //
    //
    //        moviePlayer.prepareToPlay()
    //        moviePlayer.play()
    //
    //    }
    //
    override func prepareForReuse() {
        super.prepareForReuse()
        
        movieView = nil
        videoURL = nil
        
    }
=======
    func displayVideo() {

//        let url = NSURL(string:
//            self.videoUrl)
//        let player = AVPlayer(URL: url!)
//        let playerController = AVPlayerViewController()
//        
//        playerController.player = player
//       // cell.addChildViewController(playerController)
//        movieView.addSubview(playerController.view)
//        playerController.view.frame = movieView.frame
//        
//        player.play()

        
        let url = NSURL(string: self.videoUrl)
        let player = AVPlayer(URL: url!)
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        // cell.addChildViewController(playerController)
        self.movieView.addSubview(playerController.view)
        playerController.view.frame = self.movieView.frame

            player.play()

        
        

        
    }
    
    
    //Action to load video
    func pauseVideo() {
        //        //this works
        //        let url = NSURL(string:
        //            self.videoUrl)
        //        let player = AVPlayer(URL: url!)
        //        let playerController = AVPlayerViewController()
        //
        //        playerController.player = player
        //       // cell.addChildViewController(playerController)
        //        movieView.addSubview(playerController.view)
        //        playerController.view.frame = movieView.frame
        //
        //        player.play()
        
        

        let player = AVPlayer()
        
        
        player.pause()
        
        
    }

>>>>>>> parent of c716e88... Video Feed

}
