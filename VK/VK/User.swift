//
//  User.swift
//  VK
//
//  Created by  Алёна Бенецкая on 03.11.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class User: Object  {
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var photoUrl = ""
    
    var fullName: String {
        return firstName + " " + lastName
    }
    
    convenience init(json: JSON) {
        self.init()
        id = json["id"].intValue
        firstName = json["first_name"].stringValue
        lastName = json["last_name"].stringValue
        photoUrl = json["photo_50"].stringValue
    }
}


