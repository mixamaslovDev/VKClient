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
import Alamofire
import RealmSwift

//Webview tincture for receiving information for requests

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

//Request for vkapi

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


// Get requests --------------------------------------------------------

class VkApi {
    let session = Session.shared
    
    func saveUsersData(_ friends: FriendsResponse) {
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.add(friends)
                try realm.commitWrite()
            } catch {
                print(error)
            }
        }

    
    
    func getFriends(completionHandler: @escaping (FriendsResponse) -> ()) {
        var composer = URLComponents()
        composer.scheme = "https"
        composer.host = "api.vk.com"
        composer.path = "/method/friends.get"
        composer.queryItems = [
            URLQueryItem(name: "user_id", value: session.userId),
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "count", value: ""),
            URLQueryItem(name: "fields", value: "domain,photo_50"),
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.8")
        ]
        
        Alamofire.request(composer, method: .get).responseJSON {(friendsList) in
            let friends = try! JSONDecoder().decode(FriendsResponse.self, from: friendsList.data!)
            self.saveUsersData(friends)
            completionHandler(friends)
        }
    }
    
    func getPhotos(completionHandler: @escaping (PhotosResponse) -> ()) {
        var composer = URLComponents()
        composer.scheme = "https"
        composer.host = "api.vk.com"
        composer.path = "/method/groups.get"
        composer.queryItems = [
            URLQueryItem(name: "user_id", value: session.userId),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "rev", value: "1"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.8")
        ]
        
        Alamofire.request(composer, method: .get).responseJSON {(photoList) in
            let photos = try! JSONDecoder().decode(PhotosResponse.self, from: photoList.data!)
            completionHandler(photos)
        }
    }
    
    func getGroups(completionHandler: @escaping (GroupsResponse) -> ()) {
        var composer = URLComponents()
        composer.scheme = "https"
        composer.host = "api.vk.com"
        composer.path = "/method/groups.get"
        composer.queryItems = [
            URLQueryItem(name: "user_id", value: session.userId),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: ""),
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.8")
        ]
        
        Alamofire.request(composer, method: .get).responseJSON {(groupsList) in
            let groups = try! JSONDecoder().decode(GroupsResponse.self, from: groupsList.data!)
            completionHandler(groups)
        }
    }
    
    func getGroupsSearch(text:String, completionHandler: @escaping (SearchGroupResponse) -> ()) {
        var composer = URLComponents()
        composer.scheme = "https"
        composer.host = "api.vk.com"
        composer.path = "/method/groups.search"
        composer.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "sort", value: "0"),
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.8")
        ]
        
        Alamofire.request(composer, method: .get).responseJSON {(groupsSearchList) in
            let groupsSearch = try! JSONDecoder().decode(SearchGroupResponse.self, from: groupsSearchList.data!)
            completionHandler(groupsSearch)
        }
    }
    
}

