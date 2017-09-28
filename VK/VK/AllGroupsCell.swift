//
//  AllGroupsCell.swift
//  VK
//
//  Created by  Алёна Бенецкая on 26.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit

class AllGroupsCell: UITableViewCell {

    
    @IBOutlet weak var nameGroup: UILabel!
    
    @IBOutlet weak var countManinGroup: UILabel!
    //    @IBOutlet weak var countFriendsinGroup: UILabel!
//    @IBOutlet weak var nameAllGroup: UILabel!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
