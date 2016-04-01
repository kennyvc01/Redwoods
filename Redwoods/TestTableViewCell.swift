//
//  TestTableViewCell.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/29/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import MediaPlayer

class TestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblUrl: UILabel!
    @IBOutlet weak var lablName: UILabel!
    @IBOutlet weak var lblTimestamp: UILabel!
    
    @IBOutlet weak var vwVideoView: UIView!
    
    @IBOutlet weak var movieView:UIView!
    
    
    
    var moviePlayer:MPMoviePlayerController!
    var videoURL:NSURL!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        moviePlayer = MPMoviePlayerController(contentURL: videoURL)
    }
    
    override func layoutSubviews() {
        //layout movieplayer
        moviePlayer.view.frame = movieView.bounds
        moviePlayer.view.center = CGPointMake(CGRectGetMidX(movieView.bounds), CGRectGetMidY(movieView.bounds))
        movieView.addSubview(moviePlayer.view)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}



