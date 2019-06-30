//
//  FeedTableViewCell.swift
//  Instagramclone
//
//  Created by McKinney family  on 6/30/19.
//  Copyright © 2019 FasTek Technologies. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postedImage: UIImageView!
    
    @IBOutlet weak var usernameLbl:UILabel!
    @IBOutlet weak var messageLbl:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
