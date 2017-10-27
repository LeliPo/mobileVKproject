//
//  StartViewController.swift
//  VK
//
//  Created by  Алёна Бенецкая on 01.10.17.
//  Copyright © 2017  Алёна Бенецкая. All rights reserved.
//
import Foundation
import UIKit
import WebKit
import Alamofire

struct AuthRouter {
    
    private let environment: Environment
    
    func login() -> URLRequestConvertible {
        return Login(environment: environment)
    }
    
    init(environment: Environment){
        self.environment = environment
    }
    
    private(set) lazy var notSingleton: NotSingleton = NotSingletonImp()
}

protocol NotSingleton {
    func someAction()
}

extension AuthRouter {
    
       class NotSingletonImp: NotSingleton {
        func someAction() {
            
        }
    }
    
}

extension AuthRouter {
    
        struct Login: RequestRouter {
        
        let environment: Environment
        
        init(environment: Environment) {
            self.environment = environment
        }
        
        var baseUrl: URL {
            return environment.authBaseUrl
        }
        
        let method: HTTPMethod = .get
        
        let path: String = "/authorize"
        
        var parameters: Parameters {
            return [
                "client_id": environment.clientId,
                "display": "mobile",
                "redirect_uri": "https://oauth.vk.com/blank.html",
                "scope": "270342",
                "response_type": "token",
                "v": environment.apiVersion
            ]
        }
    }
    
}



let userDefaults = UserDefaults.standard
class StartViewController: UIViewController {
    
    @IBOutlet weak var startWebVieW: WKWebView!
        {
        didSet{
            startWebVieW.navigationDelegate = self
        }
    }
    
    var environment: Environment {
        return EnvironmentImp.Debug()
    }
    
    lazy var router: AuthRouter = AuthRouter(environment: environment)
    
    var token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLogin()
    }
    
    func showLogin() {
        do {
            let request = try router.login().asURLRequest()
            startWebVieW.load(request)
        } catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toApp", let tabs = segue.destination as? TabsImp {
            tabs.token = token
        }
    }
    
}

extension AuthVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else {
                
                decisionHandler(.allow)
                return
        }
        
        let params = parse(paramters: fragment)
        
        guard let token = params["access_token"] else {
            print("токен не обнаружен")
            return
        }
        
        self.token = token
        
        decisionHandler(.cancel)
        performSegue(withIdentifier: "toLoginPage", sender: nil)
    }
    
    func parse(paramters: String) -> [String: String] {
        
        let params = paramters
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        return params
    }
}
