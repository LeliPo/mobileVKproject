//
//  File.swift
//  VK
//
//  Created by  Алёна Бенецкая on 03.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import RealmSwift

class Friend: Object {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var photoAvatar = ""
    @objc dynamic var userID = 0
    convenience init(firstName: String, lastName: String, photoAvatar: String, userID: Int) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
        self.photoAvatar = photoAvatar
        self.userID = userID
    }
}

