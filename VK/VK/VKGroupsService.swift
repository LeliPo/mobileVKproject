//
//  VKGroupsService.swift
//  VK
//
//  Created by  Алёна Бенецкая on 29.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//
import Foundation
import RealmSwift

class VKGroupsService : Object  {
   @objc  dynamic var id : UInt
   @objc  dynamic var name : String
   @objc  dynamic var description : String
   @objc  dynamic var membersCount : Int
   @objc  dynamic var photoURL : String
    
   convenience init( _ group : Any) {
    self.init()
        let group  = group as! [String: Any]
        self.id = group["gid"] as! UInt
        self.name = group["name"] as! String
        self.description = group["description"] as? String ?? ""
        self.photoURL = group["photo"] as? String ?? ""
        self.membersCount = group["members_count"] as? Int ?? 0
    }
}
