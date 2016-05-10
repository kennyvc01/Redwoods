//
//  OrgTableViewCell.swift
//  Redwoods
//
//  Created by Ken Churchill on 5/9/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit

class OrgTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCharity: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var txtWebsite: UITextView!
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
