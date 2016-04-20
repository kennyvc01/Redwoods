//
//  ActivityTableViewCell.swift
//  Redwoods
//
//  Created by Ken Churchill on 2/16/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var LblActivityLabel1: UILabel!
    @IBOutlet weak var LblActivityLabel2: UILabel!
    @IBOutlet weak var LblActivityLabel3: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
