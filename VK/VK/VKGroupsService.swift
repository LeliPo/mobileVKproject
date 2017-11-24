//
//  VKGroupsService.swift
//  VK
//
//  Created by  Алёна Бенецкая on 29.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

class GroupsRequest {
    let baseURL = "https://api.vk.com"
    typealias loadGroupDataCompletion = ([Group]) -> ()
    
    func loadGroupSearchData(completion: @escaping loadGroupDataCompletion) {
        let path = "/method/groups.search"
        let url = baseURL + path
        
        let parameters: Parameters = [
            "q": userDefaults.string(forKey: "whatYouSearch") ?? print("no search"),
            "type": "group",
            "access_token": userDefaults.string(forKey: "token") ?? print("no Token")
        ]
        
        Alamofire.request(url, parameters: parameters).responseData(queue: .global(qos: .userInteractive)) { response in
            guard let data = response.value else { return }
            let json = JSON(data)
            let groups = json["response"].flatMap { Group(json: $0.1) }
            completion(groups)
        }
    }
}
