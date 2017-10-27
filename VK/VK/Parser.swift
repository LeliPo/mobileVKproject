//
//  File.swift
//  VK
//
//  Created by  Алёна Бенецкая on 24.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JsonParser {
    func parse(_ json: JSON) -> [AnyObject]
}
