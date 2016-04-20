//
//  CharitySearchTableViewCell.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/26/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit

class CharitySearchTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCharity: UILabel!
    @IBOutlet weak var lblCharityDescription: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblDonor: UILabel!

    @IBOutlet weak var txtWebsite: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
