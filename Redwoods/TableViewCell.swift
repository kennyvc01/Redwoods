//
//  TableViewCell.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/16/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import MediaPlayer

class TableViewCell: UITableViewCell {


    
    @IBOutlet weak var movieView:UIView!
    
    @IBOutlet weak var lblCharity: UILabel!
    @IBOutlet weak var lblAmount: UILabel!

    
    var moviePlayer:MPMoviePlayerController!
    var videoURL:NSURL!
    
    var completelyVisible: Bool = true
    
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
