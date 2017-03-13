//
//  DiscoveryTableViewCell.swift
//  FoodPin
//
//  Created by wang jing on 16/12/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class DiscoveryTableViewCell: UITableViewCell {
    @IBOutlet var restaurantType:UILabel!
    @IBOutlet var restaurantName:UILabel!
    @IBOutlet var restaurantLocation:UILabel!
    @IBOutlet var restaurantImage:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
