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
    @objc dynamic var name = ""
    @objc dynamic var photo = ""
    @objc dynamic var newsID = 0
    @objc dynamic var text = ""
    @objc dynamic  var groupName = ""
    @objc dynamic var groupPhoto = ""
    convenience init(json: JSON) {
        self.init()
        self.name = json["name"].stringValue
        self.photo = json["attachments"]["photo"]["photo_75"].stringValue
        self.newsID = json["id"].intValue
        self.text = json["text"].stringValue
        self.groupName = json["groups"]["name"].stringValue
        self.groupPhoto = json["groups"]["photo_50"].stringValue
    }
}
