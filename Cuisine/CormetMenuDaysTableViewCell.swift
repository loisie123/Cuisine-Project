//
//  CormetMenuDaysTableViewCell.swift
//  Cuisine
//
//  Created by Lois van Vliet on 26-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit

class CormetMenuDaysTableViewCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var likesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
