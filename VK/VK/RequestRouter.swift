//
//  RequestRouter.swift
//  VK
//
//  Created by  Алёна Бенецкая on 24.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation
import Alamofire

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
