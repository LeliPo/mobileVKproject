//
//  MyWallCell.swift
//  VK
//
//  Created by  Алёна Бенецкая on 16.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit

class MyWallCell: UITableViewCell {

    @IBOutlet weak var textNews: UITextView!
    @IBOutlet weak var viewsCount: UILabel!
    @IBOutlet weak var countComents: UILabel!
    @IBOutlet weak var countLike: UILabel!
    @IBOutlet weak var countRepost: UILabel!
    @IBOutlet weak var photoNews: UIImageView!
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
