//
//  ChatCell.swift
//  ParseChat
//
//  Created by Elizabeth on 2/25/18.
//  Copyright © 2018 Elizabeth. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var chatMessageField: UILabel!
    @IBOutlet weak var userNameLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
