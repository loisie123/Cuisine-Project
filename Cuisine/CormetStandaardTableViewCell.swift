//
//  CormetStandaardTableViewCell.swift
//  Cuisine
//
//  Created by Lois van Vliet on 24-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit

class CormetStandaardTableViewCell: UITableViewCell {

    @IBOutlet weak var nameMeal: UILabel!
    @IBOutlet weak var priceMeal: UILabel!

    @IBOutlet weak var likesMeal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
