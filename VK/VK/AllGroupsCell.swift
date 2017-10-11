//
//  AllGroupsCell.swift
//  VK
//
//  Created by  Алёна Бенецкая on 26.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit

class AllGroupsCell: UITableViewCell {

    
    @IBOutlet weak var nameAllGroups: UILabel!
    @IBOutlet weak var countManinGroups: UILabel!
    @IBOutlet weak var groupFhoto: UIImageView!
    
   

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
