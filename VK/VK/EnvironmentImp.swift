//
//  EnvironmentImp.swift
//  VK
//
//  Created by  Алёна Бенецкая on 24.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation


struct EnvironmentImp {
    private init(){}
}

extension EnvironmentImp {
    
    struct Debug: Environment {
        let authBaseUrl = URL(string: "https://oauth.vk.com")!
        let baseUrl = URL(string: "https://api.vk.com")!
        var clientId = "6195592"
        var apiVersion = "5.68"
    }
    
}
