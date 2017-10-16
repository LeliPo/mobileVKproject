//
//  MyWallCell.swift
//  VK
//
//  Created by  Алёна Бенецкая on 16.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit

class MyWallCell: UITableViewCell {

    @IBOutlet weak var textNews: UILabel!
    @IBOutlet weak var fotoNews: UIImageView!
    @IBOutlet weak var fotoFriendsNews: UIImageView!
    @IBOutlet weak var nameFriendNews: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
