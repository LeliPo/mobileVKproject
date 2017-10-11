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
        
        Alamofire.request(url, parameters: parameters).responseData { [weak self] response in // без SwiftyJSON
            let json = try! JSONSerialization.jsonObject(with: response.value!, options: JSONSerialization.ReadingOptions.mutableContainers)
            
            var friends = [Friend]()
            
            let dict = json as! [String: Any]
            for (_, array) in dict {
                for value in array as! [Any] {
                    let userJSON = value as! [String:Any]
                    let firstName = userJSON["first_name"] as! String
                    let lastName = userJSON["last_name"] as! String
                    let photoAvatar = userJSON["photo_50"] as! String
                    let userID = userJSON["user_id"] as! Int
                    friends.append(Friend(firstName: firstName, lastName: lastName, photoAvatar: photoAvatar, userID: userID))
                }
            }
            self?.saveFriendsData(friends, count: friends.count)
            completion()
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
