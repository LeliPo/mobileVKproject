//
//  AllFriendsCell.swift
//  VK
//
//  Created by  Алёна Бенецкая on 26.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit

class AllFriendsCell: UITableViewCell {

   var idFrend : UInt!
    
    @IBOutlet weak var friendsAvatar: UIImageView!
    @IBOutlet weak var friendsNamee: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
