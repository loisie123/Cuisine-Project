//
//  UsersTableViewCell.swift
//  Cuisine
//
//  Created by Lois van Vliet on 16-01-17.
//  Copyright © 2017 Lois van Vliet. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    @IBOutlet weak var imageUser: UIImageView!

    @IBOutlet weak var usersName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
