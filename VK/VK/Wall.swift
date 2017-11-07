//
//  File.swift
//  VK
//
//  Created by  Алёна Бенецкая on 16.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Wall : Object {
   @objc dynamic var id = 0
   @objc dynamic var sourceId = 0
   @objc dynamic var likesCount = 0
   @objc dynamic var repostsCount = 0
   @objc dynamic var commentsCount = 0
   @objc dynamic var viewsCount = 0
   @objc dynamic var text = ""
   @objc dynamic var photoLink: String?
   @objc dynamic var user: User?
   @objc dynamic var group: Group?
}
