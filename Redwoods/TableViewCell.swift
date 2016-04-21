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

    var indexPath : NSInteger = 0
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
        
        let cache = Haneke.Shared.dataCache
        
        cache.fetch(URL: story.link).onSuccess { (_) in
            let path = NSURL(string: DiskCache.basePath())!.URLByAppendingPathComponent("shared-data/original")
            let cached = DiskCache(path: path.absoluteString).pathForKey(story.link.absoluteString)
            let file = NSURL(fileURLWithPath: cached)
            
            if self.indexPath == 1 {
                self.movieView.play(file)
                self.movieView.pause()
            } else {
                self.movieView.play(file)
            }
        }.onFailure { (error) in
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
