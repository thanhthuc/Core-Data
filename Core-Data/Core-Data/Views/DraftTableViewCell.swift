//
//  ShoutOutDraftTableViewCell.swift
//  Core-Data
//
//  Created by Thuc on 11/2/17.
//  Copyright © 2017 Thuc. All rights reserved.
//

import UIKit

class DraftTableViewCell: UITableViewCell {

    @IBOutlet weak var startAvatar: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
