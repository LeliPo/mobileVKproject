//
//  File.swift
//  VK
//
//  Created by  Алёна Бенецкая on 03.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Friend: Object {
    @objc dynamic var userID = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var photoAvatar = ""
    
    
    convenience init(json: JSON) {
        self.init()
        firstName = json["first_name"].stringValue
        lastName = json["last_name"].stringValue
        photoAvatar = json["photo_50"].stringValue
        userID = json["user_id"].intValue
    }
}

