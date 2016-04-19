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
    
<<<<<<< HEAD
    var shouldPlay = false
    var story: Story? {
        didSet {
            if (story != nil) { populate(story!)}
            
        }
    }
    
=======
>>>>>>> parent of c716e88... Video Feed
    @IBOutlet var movieView: LoopingVideoView!
    
    @IBOutlet weak var lblCharity: UILabel!
    @IBOutlet weak var lblAmount: UILabel!

<<<<<<< HEAD
    private func populate(story: Story) {
        lblCharity.text = story.organization.name ?? ""
        lblAmount.text = "Your $\(story.organization.amount) monthly is doing this!"
        
        movieView.prepare(story.link, autoplay: shouldPlay, succeed: {
            print("Asset has been prepared")
        }) { (error) in
            print(error)
        }
    }
=======
    
    var videoURL: NSURL!

>>>>>>> parent of c716e88... Video Feed
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    //Action to load video
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
        
        videoURL = nil
        
    }
    
    

}
