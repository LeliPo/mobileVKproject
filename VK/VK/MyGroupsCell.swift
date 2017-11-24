//
//  MyGroupsCell.swift
//  VK
//
//  Created by  Алёна Бенецкая on 03.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit

class MyGroupsCell: UITableViewCell {
    
    @IBOutlet weak var nameGroupMy: UILabel!
    @IBOutlet weak var avatarMyGroup: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


