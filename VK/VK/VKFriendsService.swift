//
//  VKFriendsService.swift
//  VK
//
//  Created by  Алёна Бенецкая on 29.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import Alamofire

class VKFriendsService{
    
  let sessionManager = sessionManagerG
    
    func getFriends(){
        
        let parameters: Parameters = [
            "count" : "10",
           "access_token" : "\(globalToken)",
            "v" : "5.68",
            "fields" : "nickname"
        ]
        
        sessionManager.request("https://api.vk.com/method/friends.get", parameters: parameters).responseJSON { response in
            
            print(response.value ?? response.error ?? "fucked up")
        }
        
    }
    
    func getPhotos(ownerID: String){
        
        let parameters: Parameters = [
            "owner_id": ownerID,
            "extended" : "0",
            "count" : "10",
            "no_service_albums" : "1",
          "access_token" : "\(globalToken)",
            "v" : "5.68"
        ]
        
        sessionManager.request("https://api.vk.com/method/photos.getAll", parameters: parameters).responseJSON { response in
            
            print(response.value ?? response.error ?? "fucked up")
        }
        
    }
    
    
    
}
