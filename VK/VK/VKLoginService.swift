//
//  File.swift
//  VK
//
//  Created by  Алёна Бенецкая on 29.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import Alamofire



enum methodRequest : String {
    case getMyFrends   = "/friends.get"
    case getPhotos     = "/photos.getAll"
    case getGroups     = "/groups.get"
    case getGroupsById = "/groups.getById"
    case searchGroup   = "/groups.search"
}

class VKLoginService {
    
    fileprivate let baseURLMethod = "https://api.vk.com"
    fileprivate let client_id = "6205040"
    fileprivate let path = "/method"
    fileprivate let version = "5.68"
    
    static var token = ""
    static var userId = 0
    
    func getFrends( completion: @escaping ([VKFriendsService]) -> Void) {
        
        let parameters: Parameters = ["user_id"  : VKLoginService.userId,
                                      "order"    : "name",
                                      "fields"   : "nickname,photo_50,photo_100",
                                      "version"  : version]
        
        let url = baseURLMethod + path + methodRequest.getMyFrends.rawValue + "?"
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            let responseVk = response.value as! [String: Any]
            let dataUsersAny = responseVk["response"] as! [Any]
            let myFrends = dataUsersAny.map(){ VKFriendsService($0) }
            completion(myFrends)
        }
    }
    
    func getMyGroups( completion: @escaping ([VKGroupsService]) -> Void) {
        
        let parameters: Parameters = [ "access_token" : VKLoginService.token,
                                       "user_id"      : VKLoginService.userId,
                                       "extended"     : "1",
                                       "fields"       : "description",
                                       "version"      : version]
        
        let url = baseURLMethod + path + methodRequest.getGroups.rawValue + "?"
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            let responseVk = response.value as! [String: Any]
            let dataGroupsAny = responseVk["response"] as! [Any]
            
            let countGroups = dataGroupsAny.count - 1
            var myGroups = [VKGroupsService]()
            
            for number in 1...countGroups {
                myGroups.append(VKGroupsService(dataGroupsAny[number]))
            }
            completion(myGroups)
        }
    }
    
    func searchGroups( searchText : String, completion: @escaping ([VKGroupsService]) -> Void) {
        var groupsId = ""
        var parameters: Parameters = [ "access_token" : VKLoginService.token,
                                       "q"       : searchText,
                                       "type"    : "group",
                                       "count"   : "20",
                                       "version" : version]
        
        var url = baseURLMethod + path + methodRequest.searchGroup.rawValue + "?"
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            let responseVk = response.value as! [String: Any]
            let dataGroupsAny = responseVk["response"] as! [Any]
            let countGroups = dataGroupsAny.count - 1
            
            for number in 1...countGroups {
                let group  = dataGroupsAny[number] as! [String: Any]
                let id = group["gid"] as! UInt
                groupsId = groupsId + "," + String(id)
            }
            
            parameters.removeAll()
            parameters = [ "access_token" : VKLoginService.token,
                           "group_ids" : groupsId,
                           "fields"    : "members_count",
                           "version"   : self.version]
            url = self.baseURLMethod + self.path + methodRequest.getGroupsById.rawValue + "?"
            
            Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
                let responseVk = response.value as! [String: Any]
                let dataGroupsAny = responseVk["response"] as! [Any]
                let myGroups = dataGroupsAny.map(){ VKGroupsService($0) }
                completion(myGroups)
            }
        }
    }
}


