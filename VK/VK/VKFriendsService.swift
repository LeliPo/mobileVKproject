//
//  VKFriendsService.swift
//  VK
//
//  Created by  Алёна Бенецкая on 29.09.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

struct FriendService {
    
    private let router: UserRouter
    
    init(environment: Environment, token: String) {
        router = UserRouter(environment: environment, token: token)
    }
    
    func dowloadFriends() {
        Alamofire.request(router.userList()).responseData { response in
            
            guard let data = response.value else { return }
            let json = JSON(data: data)
            let users = json["response"]["items"].array?.flatMap { Friend(json: $0) } ?? []
            Realm.replaceAllObjectOfType(toNewObjects: users)
        }
    }
    
    func downloadPhoto(forUser user: Int, completion: @escaping ([Photo]) -> Void) {
        Alamofire.request(router.userPhotoList(ownerId: user)).responseData { response in
            
            guard let data = response.value else { return }
            let json = JSON(data: data)
            let photos = json["response"]["items"].array?.flatMap { Photo(json: $0) } ?? []
            completion(photos)
        }
    }
    
    func loadFriends() -> [Friend] {
        do {
            let realm = try Realm()
            return Array(realm.objects(Friend.self))
        } catch {
            print(error)
            return []
        }
    }

}

struct UserRouter {
    
    private let environment: Environment
    private let token: String
    
    func userList() -> URLRequestConvertible {
        return UserList(environment: environment, token: token)
    }
    
    func userPhotoList(ownerId: Int) -> URLRequestConvertible {
        return UserPhotoList(environment: environment, token: token, ownerId: ownerId)
    }
    
    init(environment: Environment, token: String){
        self.environment = environment
        self.token = token
    }
}

extension UserRouter {
    
        struct UserList: RequestRouter {
        let environment: Environment
        let token: String
        
        init(environment: Environment, token: String) {
            self.environment = environment
            self.token = token
        }
        
        var baseUrl: URL {
            return environment.baseUrl
        }
        
        let method: HTTPMethod = .get
        
        var path = "/method/friends.get"
        
        var parameters: Parameters {
            return [
                "access_token": token,
                "v": environment.apiVersion,
                "fields":"nickname,domain,photo_50"
            ]
        }
    }
}

extension UserRouter {
    
        struct UserPhotoList: RequestRouter {
        let environment: Environment
        let token: String
        let ownerId: Int
        
        init(environment: Environment, token: String, ownerId: Int) {
            self.environment = environment
            self.token = token
            self.ownerId = ownerId
        }
        
        var baseUrl: URL {
            return environment.baseUrl
        }
        
        var method: HTTPMethod = .get
        
        var path = "/method/photos.getAll"
        
        var parameters: Parameters {
            return [
                "owner_id": ownerId,
                "access_token": token,
                "v": environment.apiVersion,
                "fields":"nickname,domain,photo_50"
            ]
        }
    }
    
}

