//
//  PortfolioTableViewCell.swift
//  Redwoods
//
//  Created by Ken Churchill on 3/31/16.
//  Copyright © 2016 Ken Churchill. All rights reserved.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCharityName: UILabel!
    @IBOutlet weak var lblDonationAmount: UILabel!
    @IBOutlet weak var lblDonationDay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
