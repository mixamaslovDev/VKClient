//
//  User.swift
//  VKClient
//
//  Created by Михаил Маслов on 18/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit
import RealmSwift

struct User {
    var name: String
    var photo: [UIImage?]
}


var usr = [
    User(name: "Maslov Mikhail", photo: [UIImage(named: "Maslov Mikhail"),UIImage(named: "Pavel Durov")] ),
    User(name: "Steve Jobs", photo: [UIImage(named: "Steve Jobs"), UIImage(named: "Pavel Durov")]),
    User(name: "Bill Gates", photo: [UIImage (named: "Bill Gates"), UIImage(named: "Pavel Durov")]),
    User(name: "Top Gamer", photo: [UIImage (named: "Top Gamer"), UIImage(named: "Pavel Durov")]),
    User(name: "Pavel Durov", photo: [UIImage (named: "Pavel Durov"), UIImage(named: "Pavel Durov")]),
    User(name: "Jeff Bezos", photo: [UIImage (named: "Jeff Bezos"), UIImage(named: "Pavel Durov")]),
    User(name: "Mark Zuckerberg", photo: [UIImage (named: "Mark Zuckerberg"), UIImage(named: "Pavel Durov")]),
    User(name: "Kirill Sencov", photo: [UIImage (named: "KV"), UIImage(named: "Pavel Durov")])
]

var users =  usr.sorted(by: {$0.name < $1.name})

var allImages = users.flatMap({$0.photo})



class FriendsResponse: Object, Codable {
    @objc dynamic var response: ResponseFriends
    
//    convenience init(response: ResponseFriends) {
//        self.init()
//        self.response = response
//    }
}

// MARK: - Response
class ResponseFriends: Object, Codable {
    @objc dynamic var count = 0
    @objc dynamic var items: [UserItem]
    
//   convenience init(items: [UserItem]) {
//        self.init()
////        self.count = count
//        self.items = items
//    }
}

// MARK: - Item
class UserItem: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var domain = ""
    @objc dynamic var photo_50 = ""
    @objc dynamic var online = 0
    @objc dynamic var trackCode = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case domain, photo_50, online
        case trackCode = "track_code"
    }
    
//    convenience init(id: Int, firstName: String, lastName: String, domain: String, photo_50: String, online: Int, trackCode: String) {
//        self.init()
//        self.id = id
//        self.firstName = firstName
//        self.lastName = lastName
//        self.domain = domain
//        self.photo_50 = photo_50
//        self.online = online
//        self.trackCode = trackCode
//    }
}

