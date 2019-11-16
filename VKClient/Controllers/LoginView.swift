//
//  LoginView.swift
//  VKClient
//
//  Created by Михаил Маслов on 26.10.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//
//App id = 7193721


import UIKit
import WebKit

//Webview tincture for receiving information for requests --------------------

extension LoginView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html" else {
                decisionHandler(.allow)
                return
        }
        let param = url.fragment?
            .components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String:String](), {(result, params) in
                var dict = result
                let key = params[0]
                let value = params[1]
                dict[key] = value
                return dict
            })
        let session = Session.shared
        session.token = param?["access_token"] ?? ""
        session.userId = param?["user_id"] ?? ""
        
        print(session.token ?? "", session.userId ?? "")
        
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "tabbar") as! UIViewController
        self.present(viewController, animated: true)
        decisionHandler(.cancel)
        
    }
}

//Login

class LoginView: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        var composer = URLComponents()
        composer.scheme = "https"
        composer.host = "oauth.vk.com"
        composer.path = "/authorize"
        composer.queryItems = [
            URLQueryItem(name: "client_id", value: "7193721"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.8")
        ]
        
        webView.load(URLRequest(url: composer.url!))
        webView.navigationDelegate = self
        
        
        
    }
    
}
