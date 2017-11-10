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
//    convenience init(firstName: String, lastName: String, photoAvatar: String, userID: Int) {
//        self.init()
//        self.firstName = firstName
//        self.lastName = lastName
//        self.photoAvatar = photoAvatar
//        self.userID = userID
//    }
    
//    let firstName = userJSON["first_name"] as! String
//    let lastName = userJSON["last_name"] as! String
//    let photoAvatar = userJSON["photo_50"] as! String
//    let userID = userJSON["user_id"] as! Int
}

