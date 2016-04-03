//
//  Test2TableViewCell.swift
//  Redwoods
//
//  Created by Ken Churchill on 4/1/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit

class Test2TableViewCell: UITableViewCell {
    @IBOutlet weak var lblCharityName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDonor: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
