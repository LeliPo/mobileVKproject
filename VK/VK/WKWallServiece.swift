//
//  Wall.swift
//  VK
//
//  Created by  Алёна Бенецкая on 16.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON





struct NewsRouter {
    
    private let environment: Environment
    private let token: String
    
    func list() -> URLRequestConvertible {
        return List(environment: environment, token: token)
    }
    
    init(environment: Environment, token: String){
        self.environment = environment
        self.token = token
    }
}


struct NewsService {
    
    private let router: NewsRouter
    private let parser: JsonParser = ParserFactory().newsFeed()
    
    
    init(environment: Environment, token: String) {
        router = NewsRouter(environment: environment, token: token)
    }
    
    func downloadsNews(completion: @escaping ([Wall]) -> Void) {
        
        Alamofire.request(router.list()).responseData(queue: .global(qos: .userInteractive)) { response in
            guard let data = response.value else { return }
            let json = JSON(data: data)
            let news = self.parser.parse(json) as? [Wall]
            DispatchQueue.main.async {
                completion(news ?? [])
            }
            
        }
    }
    
}

extension NewsRouter {
    
        struct List: RequestRouter {
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
        
        var path = "/method/newsfeed.get"
        
        var parameters: Parameters {
            return [
                "filters": "post,photo",
                "access_token": token,
                "v": environment.apiVersion
            ]
        }
    }
}

















//import Foundation
//import Alamofire
//import SwiftyJSON
//import RealmSwift
//
//class WallRequest {
//    let baseURL = "https://api.vk.com"
//    typealias loadWallDataCompletion = ([Wall]) -> Void
//
//    func newRequest () {
//        let path = "/method/newsfeed.get"
//        let url = baseURL + path
//        let parameters: Parameters = [
//            "access_token": userDefaults.string(forKey: "token") ?? print("no Token"),
//            "count": "10",
//            "max_photos" : "10",
//            "filters": "post, photo",
//            "v": "5.68"
//        ]
//
//        Alamofire.request(url, method: .get, parameters: parameters).responseData { response in
//            guard let data = response.value else { return }
//            let json = JSON(data)
//            var news:[Wall] = [Wall]()
//            for (_, j) in json["response"]["items"] {
//                if "post" == j["type"].stringValue {
//                    news.append(Wall(json : j))
//                }
//            }
//            self.saveNewsData(news)
//        }
//    }
//
//    func saveNewsData(_ news: [Wall]) {
//        do {
//            let realm = try Realm()
//            let oldNews = realm.objects(Wall.self)
//            try realm.write {
//                realm.delete(oldNews)
//                realm.add(news)
//                try realm.commitWrite()
//            }
//
////            realm.beginWrite()
////            if oldNews.count != count { realm.delete(oldNews) }
////            realm.add(news)
//           // try realm.commitWrite()
//        } catch {
//            print(error)
//        }
//    }
//
//}

