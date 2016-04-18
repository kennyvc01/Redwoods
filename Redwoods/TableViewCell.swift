//
//  TableViewCell.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/16/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Haneke

class TableViewCell: UITableViewCell {
    
    var shouldPlay = false
    var story: Story? {
        didSet {
            if (story != nil) { populate(story!)}
            
        }
    }
    
    @IBOutlet var movieView: LoopingVideoView!
    @IBOutlet weak var lblCharity: UILabel!
    @IBOutlet weak var lblAmount: UILabel!

    private func populate(story: Story) {
        lblCharity.text = story.organization.name ?? ""
        lblAmount.text = "Your $\(story.organization.amount) monthly is doing this!"
        
        movieView.prepare(story.link, autoplay: shouldPlay, succeed: {
            print("Asset has been prepared")
        }) { (error) in
            print(error)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
        story = nil
        lblCharity.text = nil
        lblAmount.text = nil
        movieView.playerLayer.player = nil
    }
    
    

}
