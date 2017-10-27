//
//  Environment.swift
//  VK
//
//  Created by  Алёна Бенецкая on 24.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import Foundation

protocol Environment {
    var authBaseUrl: URL { get }
    var baseUrl: URL { get }
    var clientId: String { get }
    var apiVersion: String { get }
}
