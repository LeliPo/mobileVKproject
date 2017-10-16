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

class WallRequest {
    let baseURL = "https://api.vk.com"
    typealias loadGroupDataCompletion = ([Wall]) -> ()
    
    func loadGroupSearchData(completion: @escaping loadGroupDataCompletion) {
        let path = "/method/wall.get"
        let url = baseURL + path
        
        let parameters: Parameters = [
            "owner_id": userDefaults.string(forKey: "whoIsYourFriend") ?? print("No ID"),
            "count": "10",
            "filter": "all",
            "extended" : "1",
            "fields" : "first_name, last_name, photo_50, name ",
            "access_token": userDefaults.string(forKey: "token") ?? print("no Token")
        ]
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            guard let data = response.value else { return }
            let json = JSON(data)
            let news = json["response"].flatMap { Wall(json: $0.1) }
            completion(news)
        }
    }
}
