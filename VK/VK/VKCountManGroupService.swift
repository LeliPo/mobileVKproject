//
//  File.swift
//  VK
//
//  Created by  Алёна Бенецкая on 11.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class CountMembersRequest {
    let baseURL = "https://api.vk.com"
    
    func loadMembersCount(completion: @escaping ([Int]) -> Void) {
        
        let path = "/method/groups.search"
        let url = baseURL + path
        
        let parameters: Parameters = [
            "q": userDefaults.string(forKey: "whatYouSearch") ?? print("no search"),
            "type": "group",
            "access_token": userDefaults.string(forKey: "token") ?? print("no Token")
        ]
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            let responseGroupGet = response.value as! [String: Any]
            var allData = responseGroupGet["response"] as! [Any]
            allData.remove(at: 0)
            var groupIDs = [Int]()
            var groupIDsString = ""
            for value in allData {
                let group = value as! [String: Any]
                groupIDs.append(group["gid"] as! Int)
            }
            for i in groupIDs {
                groupIDsString = groupIDsString + "," + String(i)
            }
            
            let newPath = "/method/groups.getById"
            let newUrl = self.baseURL + newPath
            
            let newParameters: Parameters = [
                "group_ids": groupIDsString,
                "fields": "members_count",
                "access_token": userDefaults.string(forKey: "token") ?? print("no Token")
            ]
            
            Alamofire.request(newUrl, parameters: newParameters).responseJSON { response in
                let responseGroupsMembersCount = response.value as! [String: Any]
                let array = responseGroupsMembersCount["response"] as! [Any]
                for value in array {
                    let dict = value as! [String: Any]
                    membersCount.append(dict["members_count"] as! Int)
                }
                completion(membersCount)
            }
        }
    }
}

var membersCount = [Int]()

