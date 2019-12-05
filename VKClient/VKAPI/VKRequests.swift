//
//  VkRequests.swift
//  VKClient
//
//  Created by Михаил Маслов on 16.11.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import Alamofire
import RealmSwift

class VkApi {
    
    let realm = RealmDataBase()
    func requestVK<T:Decodable> (composer: URLComponents, completionHandler: @escaping (T) -> ()) {
        
        Alamofire.request(composer, method: .get).responseJSON {(data) in
            
            do {  let request = try JSONDecoder().decode(T.self, from: data.data!)
                
                if T.self == FriendsResponse.self {
                    self.realm.saveUsersData((request as! FriendsResponse).response!.items)
                }
                if  T.self == GroupsResponse.self{
                    self.realm.saveGroupsData((request as! GroupsResponse).response!.items)
                }
                else {
                    completionHandler(request)
                }
            } catch { print(error) }
        }
        
    }
    
    
    func getFriends(completionHandler: @escaping (FriendsResponse) -> ()) {
        var composer = URLComponents()
        composer.scheme = "https"
        composer.host = "api.vk.com"
        composer.path = "/method/friends.get"
        composer.queryItems = [
            URLQueryItem(name: "user_id", value: Session.shared.userId),
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "count", value: ""),
            URLQueryItem(name: "fields", value: "domain,photo_50"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.8")
        ]
        
        requestVK(composer: composer, completionHandler: completionHandler)
        
    }
    
    func getPhotos(completionHandler: @escaping (PhotosResponse) -> ()) {
        var composer = URLComponents()
        composer.scheme = "https"
        composer.host = "api.vk.com"
        composer.path = "/method/photos.get"
        composer.queryItems = [
            URLQueryItem(name: "owner_id", value: String(idVK)),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "rev", value: "0"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.8")
        ]
        requestVK(composer: composer, completionHandler: completionHandler)
        
    }
    
    func getGroups(completionHandler: @escaping (GroupsResponse) -> ()) {
        var composer = URLComponents()
        composer.scheme = "https"
        composer.host = "api.vk.com"
        composer.path = "/method/groups.get"
        composer.queryItems = [
            URLQueryItem(name: "user_id", value: Session.shared.userId),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: ""),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.8")
        ]
        
        requestVK(composer: composer, completionHandler: completionHandler)
        
    }
    
    func getGroupsSearch(offset: Int, text: String, completionHandler: @escaping (SearchGroupResponse) -> ()) {
        var composer = URLComponents()
        composer.scheme = "https"
        composer.host = "api.vk.com"
        composer.path = "/method/groups.search"
        composer.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "sort", value: "0"),
            URLQueryItem(name: "offset", value: String(describing: offset)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.8")
        ]
        
        Alamofire.request(composer, method: .get).responseJSON {(groupsSearchList) in
          guard let groupsSearch = try? JSONDecoder().decode(SearchGroupResponse.self, from: groupsSearchList.data!)
            else { return }
            completionHandler(groupsSearch)
        }
    }
}
