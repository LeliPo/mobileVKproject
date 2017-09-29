//
//  TabBarViewController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 29.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit
import Alamofire

class TabBarViewController: UITabBarController  {

override func viewDidLoad() {
    super.viewDidLoad()
    
    configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
    
    let friendsService = VKFriendsService()
    let groupsService = VKGroupsService()
    
    
    friendsService.getFriends()
    friendsService.getPhotos(ownerID: "1502372")
    groupsService.getUsersGroups()
    groupsService.searchGroups(keyWords: "Hello world")
    
    
}
}
let configuration = URLSessionConfiguration.default
let sessionManagerG = SessionManager(configuration: configuration)
