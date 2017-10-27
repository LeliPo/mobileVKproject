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
import RealmSwift

struct GroupService {
    private let router: GroupRouter
    
    init(environment: Environment, token: String) {
        router = GroupRouter(environment: environment, token: token)
    }
    
    func dowloadGroups() {
        Alamofire.request(router.groupList()).responseData { response in
            guard let data = response.value else { return }
            let json = JSON(data: data)
            let groups = json["response"]["items"].array?.flatMap { Group(json: $0) } ?? []
            Realm.replaceAllObjectOfType(toNewObjects: groups)
        }
    }
    
    func loadGroups() -> [Group] {
        do {
            let realm = try Realm()
            return Array(realm.objects(Group.self))
        } catch {
            print(error)
            return []
        }
    }
    
    func searchGroups(request: String, completion: @escaping ([Group]) -> () ) {
        Alamofire.request(router.searchGroup(request: request)).responseData { response in
            guard let data = response.value else { return }
            let json = JSON(data: data)
            let groupsId = json["response"]["items"].array?.flatMap { String(describing: $0["id"].intValue) }.joined(separator: ",") ?? ""
            self.groupInfo(bygGoupsId: groupsId, completion: completion)
        }
    }
    
    private func groupInfo(bygGoupsId groupsId: String, completion: @escaping ([Group]) -> () ) {
        Alamofire.request(router.groupInfo(groupsID: groupsId)).responseData { response in
            guard let data = response.value else { return }
            let json = JSON(data: data)
            let groups = json["response"].array?.flatMap { Group(json: $0) } ?? []
            completion(groups)
        }
    }
    
    func joinToGroup(groupID: Int, completion: @escaping () -> () ) {
        Alamofire.request(router.joinToGroup(groupID: groupID)).responseData { response in
            completion()
        }
    }
    
    func leaveFromGroup(groupID: Int, completion: @escaping () -> () ) {
        Alamofire.request(router.leaveFromGroup(groupID: groupID)).responseData { response in
            completion()
        }
    }
    
}



struct GroupRouter {
    
    private let environment: Environment
    private let token: String
    
    func groupList() -> URLRequestConvertible {
        return GroupList(environment: environment, token: token)
    }
    
    func searchGroup(request: String) -> URLRequestConvertible {
        return SearchGroup(environment: environment, token: token, requestString: request)
    }
    
    func groupInfo(groupsID: String) -> URLRequestConvertible {
        return GroupInfo(environment: environment, token: token, groupsID: groupsID)
    }
    
    func joinToGroup(groupID: Int) -> URLRequestConvertible {
        return JoinToGroup(environment: environment, token: token, groupID: groupID)
    }
    
    func leaveFromGroup(groupID: Int) -> URLRequestConvertible {
        return LeaveFromGroup(environment: environment, token: token, groupID: groupID)
    }
    
    init(environment: Environment, token: String){
        self.environment = environment
        self.token = token
    }
}

extension GroupRouter {
    
        struct GroupList: RequestRouter {
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
        
        var path = "/method/groups.get"
        
        var parameters: Parameters {
            return [
                "extended": 1,
                "access_token": token,
                "v": environment.apiVersion
            ]
        }
    }
}

extension GroupRouter {
    
        struct SearchGroup: RequestRouter {
        let environment: Environment
        let token: String
        let requestString: String
        
        init(environment: Environment, token: String, requestString: String) {
            self.environment = environment
            self.token = token
            self.requestString = requestString
        }
        
        var baseUrl: URL {
            return environment.baseUrl
        }
        
        let method: HTTPMethod = .get
        
        var path = "/method/groups.search"
        
        var parameters: Parameters {
            return [
                "q": requestString,
                "type": "group",
                "access_token": token,
                "v": environment.apiVersion
            ]
        }
    }
}

extension GroupRouter {
    
        struct GroupInfo: RequestRouter {
        let environment: Environment
        let token: String
        let groupsID: String
        
        init(environment: Environment, token: String, groupsID: String) {
            self.environment = environment
            self.token = token
            self.groupsID = groupsID
        }
        
        var baseUrl: URL {
            return environment.baseUrl
        }
        
        let method: HTTPMethod = .get
        
        var path = "/method/groups.getById"
        
        var parameters: Parameters {
            return [
                "group_ids": groupsID,
                "fields": "members_count",
                "access_token": token,
                "v": environment.apiVersion
            ]
        }
    }
}

extension GroupRouter {
    
        struct JoinToGroup: RequestRouter {
        let environment: Environment
        let token: String
        let groupID: Int
        
        init(environment: Environment, token: String, groupID: Int) {
            self.environment = environment
            self.token = token
            self.groupID = groupID
        }
        
        var baseUrl: URL {
            return environment.baseUrl
        }
        
        let method: HTTPMethod = .get
        
        var path = "/method/groups.join"
        
        var parameters: Parameters {
            return [
                "group_id": groupID,
                "access_token": token,
                "v": environment.apiVersion
            ]
        }
    }
}

extension GroupRouter {
    
        struct LeaveFromGroup: RequestRouter {
        let environment: Environment
        let token: String
        let groupID: Int
        
        init(environment: Environment, token: String, groupID: Int) {
            self.environment = environment
            self.token = token
            self.groupID = groupID
        }
        
        var baseUrl: URL {
            return environment.baseUrl
        }
        
        let method: HTTPMethod = .get
        
        var path = "/method/groups.leave"
        
        var parameters: Parameters {
            return [
                "group_id": groupID,
                "access_token": token,
                "v": environment.apiVersion
            ]
        }
    }
}

