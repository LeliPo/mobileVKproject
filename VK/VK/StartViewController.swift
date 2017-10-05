//
//  StartViewController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 01.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit
import WebKit
//import Alamofire

class StartViewController: UIViewController {
    
    @IBOutlet weak var startWebVieW: WKWebView!

  
        {
        didSet{
            startWebVieW.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6196172"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        //request.httpShouldHandleCookies = false
        startWebVieW.load(request)
    }
}

extension StartViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        print(params)
        VKLoginService.userId = Int(params["user_id"]!)!
        let token = params["access_token"]
        decisionHandler(.allow)
        
        VKLoginService.token = (token)!
        self.performSegue(withIdentifier: "toLoginPage", sender: nil)
    }
}
