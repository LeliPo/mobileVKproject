//
//  VKGroupsService.swift
//  VK
//
//  Created by  Алёна Бенецкая on 29.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import Alamofire

class VKGroupsService{
  let sessionManager: SessionManager = sessionManagerG
    
    func getUsersGroups(){
        let parameters: Parameters = [
            "count" : "10",
            "v" : "5.68",
        "access_token" : "\(globalToken)",
            "extended" : "1"
        ]
        
        sessionManager.request("https://api.vk.com/method/groups.get", parameters: parameters).responseJSON { response in
            
            print(response.value ?? response.error ?? "fucked up")
        }
        
    }
    
    func searchGroups(keyWords: String){
        let parameters: Parameters = [
            "q" : "\(keyWords)",
            "v" : "5.68",
            "count" : "10",
            "access_token" : "\(globalToken)",
            
        ]
        
        sessionManager.request("https://api.vk.com/method/groups.search", parameters: parameters).responseJSON { response in
            
            print(response.value ?? response.error ?? "fucked up")
        }
    }
    
    
}

