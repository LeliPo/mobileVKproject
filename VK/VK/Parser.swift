//
//  Parser.swift
//  VK
//
//  Created by  Алёна Бенецкая on 03.11.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JsonParser {
    func parse(_ json: JSON) -> [AnyObject]
}

struct ParserFactory {
    
    func newsFeed() -> JsonParser {
        return ParserFactory.News()
    }
}

extension ParserFactory {
    struct News: JsonParser {
        
        static let deepType = [
            "post": nil,
            "wall_photo": "photos",
            "photo": "photos",
            "photo_tag": "profiles",
            "friend": "friends",
            "note": "profiles",
            "audio": "audio",
            "video": "video"
        ]
        
        let jsonToNew = { (json: JSON, groups: [Group], users: [Friend]) -> Wall in
            var new = Wall()
            let type = json["type"].stringValue
            
            new.id = json["post_id"].intValue
            new.sourceId = json["source_id"].intValue
            
            var json = json
            
            if let deepTypeOptional = deepType[type], let type = deepTypeOptional  {
                json = json[type]["items"][0]
            }
            
            
            new.likesCount = json["likes"]["count"].intValue
            new.repostsCount = json["reposts"]["count"].intValue
            new.commentsCount = json["comments"]["count"].intValue
            new.viewsCount = json["views"]["count"].intValue
            new.text = json["text"].stringValue
            new.photoLink = json["photo_130"].string
            
            if new.sourceId > 0 {
                new.user = users.filter { $0.userID == new.sourceId }.first
            } else {
                new.group = groups.filter { $0.groupID == abs(new.sourceId) }.first
            }
      
            return new
        }
        
        func parse(_ json: JSON) -> [AnyObject] {
            let groups = json["response"]["groups"].map { Group(json: $0.1) }
            let users = json["response"]["profiles"].map { Friend(json: $0.1) }
            return json["response"]["items"].flatMap { jsonToNew($0.1, groups, users) }
        }
        
    }
}

