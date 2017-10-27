//
//  File.swift
//  VK
//
//  Created by  Алёна Бенецкая on 16.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation

class Wall {
    var id = 0
    var sourceId = 0
    var likesCount = 0
    var repostsCount = 0
    var commentsCount = 0
    var viewsCount = 0
    var text = ""
    var photoLink: String?
    var user: Friend?
    var group: Group?
}
