//
//  Wall.swift
//  VK
//
//  Created by  Алёна Бенецкая on 16.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class WallRequest {
    let baseURL = "https://api.vk.com"
    typealias loadWallDataCompletion = ([Wall]) -> Void
    
    func loadWallSearchData(completion: @escaping () -> ()) {
        let path = "/method/newsfeed.get"
        let url = baseURL + path
        
        let parameters: Parameters = [
            "access_token": userDefaults.string(forKey: "token") ?? print("no Token"),
           // "owner_id": userDefaults.string(forKey: "yourNews") ?? print("No ID"),
            "count": "10",
            "filters": "post, photo, photo_tag, wall_photo",
           // "extended" : "1",
         //   "fields" : "first_name, last_name, photo_50, name ",
            "v": "5.68"
            
        ]
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            guard let data = response.value else { return }
            let json = JSON(data)
            var news:[Wall] = [Wall]()
            for (_, j) in json["response"]["items"] {
                if "post" == j["type"].stringValue {
                    news.append(Wall(json : j))
                }
            }
            self.saveNewsData(news, count: news.count)
        }
    }
    
    func saveNewsData(_ news: [Wall], count: Int) {
        do {
            let realm = try Realm()
            let oldNews = realm.objects(Wall.self)
            realm.beginWrite()
            if oldNews.count != count { realm.delete(oldNews) }
            realm.add(news)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

}
