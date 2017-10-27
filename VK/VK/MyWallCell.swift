//
//  MyWallCell.swift
//  VK
//
//  Created by  Алёна Бенецкая on 16.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit

class MyWallCell: UITableViewCell {

    @IBOutlet weak var textNew: UITextView!
    
    @IBOutlet weak var autorName: UILabel!
    @IBOutlet weak var autorAvatar: UIImageView!
    @IBOutlet weak var photoNew: UIImageView!
    
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var repostCount: UILabel!
    @IBOutlet weak var viewsCount: UILabel!
   

}
