//
//  Group.swift
//  VK
//
//  Created by  Алёна Бенецкая on 11.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Group: Object {
    @objc dynamic var name = ""
    @objc dynamic var photo = ""
    @objc dynamic var groupID = 0
    @objc dynamic var count = 0
    
    convenience init(json: JSON) {
        self.init()
        name = json["name"].stringValue
        photo = json["photo_100"].stringValue
        groupID = json["id"].intValue
        count = json["members_count"].intValue
    }
}
