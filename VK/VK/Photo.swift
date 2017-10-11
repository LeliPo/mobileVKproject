//
//  Photo.swift
//  VK
//
//  Created by  Алёна Бенецкая on 11.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Photo: Object {
    @objc dynamic var photo = ""
    convenience init(json: JSON) {
        self.init()
        self.photo = json["src_big"].stringValue
    }
}
