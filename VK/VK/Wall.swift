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
    @objc dynamic var newsID: String = ""
    @objc dynamic var text : String = ""
    @objc dynamic var photo : String = ""
    
    override static func primaryKey() -> String? {
        return "newsID"
    }
    

    convenience init(json: JSON) {
        self.init()
       self.newsID = json["date"].stringValue + json["post_id"].stringValue
         self.text = json["text"].stringValue
        for (_,j) in json["attachments"] {
            if j["type"].stringValue == "photo" {
                self.photo = j["photo"]["photo_75"].stringValue
            }
        }
    }
}
