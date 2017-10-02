//
//  StartViewController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 01.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var webViewStart: WKWebView!
  
        {
        didSet {
            webViewStart.navigationDelegate = self
        }
    }
    
    var service = VKLoginService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webViewStart.load(service.getrequest())
    }
    
    
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment  else {
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
        
        let token = params["access_token"]
        
        globalToken = token!
        decisionHandler(.cancel)
        
        performSegue(withIdentifier: "toLoginPage", sender: token)
    }
}

var globalToken: String = ""

