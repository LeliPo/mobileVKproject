//
//  VKGroupsService.swift
//  VK
//
//  Created by  Алёна Бенецкая on 29.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//
import Foundation

class VKGroupsService {
    var id : UInt
    var name : String
    var description : String
    var membersCount : Int
    var photoURL : String
    
    init( _ group : Any) {
        let group  = group as! [String: Any]
        self.id = group["gid"] as! UInt
        self.name = group["name"] as! String
        self.description = group["description"] as? String ?? ""
        self.photoURL = group["photo"] as? String ?? ""
        self.membersCount = group["members_count"] as? Int ?? 0
    }
}
