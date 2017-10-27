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
    @objc dynamic var url = ""
    convenience init(json: JSON) {
        self.init()
        url = json["photo_130"].stringValue
    }
}
