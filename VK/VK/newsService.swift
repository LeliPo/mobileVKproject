//
//  newsService.swift
//  VK
//
//  Created by  Алёна Бенецкая on 03.11.17.
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

protocol Environment {
    var authBaseUrl: URL { get }
    var baseUrl: URL { get }
    var clientId: String { get }
    var apiVersion: String { get }
}


struct EnvironmentImp {
    private init(){}
}

extension EnvironmentImp {
    
    struct Debug: Environment {
        let authBaseUrl = URL(string: "https://oauth.vk.com")!
        let baseUrl = URL(string: "https://api.vk.com")!
        var clientId = "6205040"
        var apiVersion = "5.68"
    }
    
}


public protocol RequestRouter: URLRequestConvertible {
    var baseUrl: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters { get }
    var fullUrl: URL { get }
}

public extension RequestRouter {
    var fullUrl: URL {
        return baseUrl.appendingPathComponent(path)
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
