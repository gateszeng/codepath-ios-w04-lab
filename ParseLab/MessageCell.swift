//
//  MessageCell.swift
//  ParseLab
//
//  Created by Gates Zeng on 2/23/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
