//
//  VKFriendsService.swift
//  VK
//
//  Created by  Алёна Бенецкая on 29.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation

class VKFriendsService {
    var id : UInt
    var firstName : String
    var lastName : String
    var smallPhotoURL : String
    var bigPhotoURL : String
    
    init( _ user : Any) {
        let user  = user as? [String: Any]
        self.id = user!["user_id"] as! UInt
        self.firstName = user!["first_name"] as! String
        self.lastName = user!["last_name"] as! String
        self.smallPhotoURL = user!["photo_50"] as! String
        self.bigPhotoURL = user!["photo_100"] as! String
    }
}
