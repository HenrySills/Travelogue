//
//  TravelTableViewCell.swift
//  Travelogue Core Data
//
//  Created by Henry Sills on 12/4/19.
//  Copyright © 2019 Dale Musser. All rights reserved.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var modifiedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
