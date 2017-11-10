//
//  VKFriendsService.swift
//  VK
//
//  Created by  Алёна Бенецкая on 29.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON

class FriendsRequest {
    let baseURL = "https://api.vk.com"
    typealias loadFriendsDataCompletion = ([Friend]) -> Void
    
    func loadFriendsData(completion: @escaping () -> () ) {
        let path = "/method/friends.get"
        let url = baseURL + path
        
        let parameters: Parameters = [
            "access_token": userDefaults.string(forKey: "token") ?? print("no Token"),
            "order": "name",
            "fields": "city,nickname,photo_50",
            "name_case": "nom",
            "version": "5.68",
            ]
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            guard let data = response.value else { return }
            let json = JSON(data)
            let friends = json["response"].flatMap { Friend(json: $0.1) }
            self.saveFriendsData(friends, count: friends.count)
            //completion(friends)
        }
    }
    
    func saveFriendsData(_ friends: [Friend], count: Int) {
        do {
            let realm = try Realm()
            let oldFriends = realm.objects(Friend.self)
            realm.beginWrite()
            if oldFriends.count != count { realm.delete(oldFriends) }
            realm.add(friends)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
