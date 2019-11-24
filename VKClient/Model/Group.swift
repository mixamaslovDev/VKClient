//
//  Group.swift
//  VKClient
//
//  Created by Михаил Маслов on 18/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

//struct group {
//    var nameGroup: String
//    var photoGroup: UIImage?
//}
//
//var groups = [group]()
//
//var groupsF = [
//    group(nameGroup: "Apple", photoGroup: UIImage(named: "Apple")),
//    group(nameGroup: "GeekBrains", photoGroup: UIImage(named: "GBrains")),
//    group(nameGroup: "Вконтакте", photoGroup: UIImage(named: "VKLogo"))
//]


import Foundation
import RealmSwift
// MARK: - GroupsResponse
class GroupsResponse: Codable {
    dynamic var response: ResponseGroups?
    
    
//    init(response: ResponseGroups) {
//        self.response = response
//    }
}

// MARK: - Response
class ResponseGroups: Codable {
    dynamic var count: Int = 0
   var items = List <GroupsItem>()

//    init(count: Int, items: [GroupsItem]) {
//        self.count = count
//        self.items = items
//    }
}

// MARK: - Item
class GroupsItem: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var isClosed: Int = 0
    @objc dynamic var type: String = ""
    @objc dynamic var isAdmin: Int = 0
    @objc dynamic var isMember: Int = 0
    @objc dynamic var isAdvertiser: Int = 0
    @objc dynamic var photo50: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var photo200: String = ""

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
//
//    init(id: Int, name: String, screenName: String, isClosed: Int, type: String, isAdmin: Int, isMember: Int, isAdvertiser: Int, photo50: String, photo100: String, photo200: String) {
//        self.id = id
//        self.name = name
//        self.screenName = screenName
//        self.isClosed = isClosed
//        self.type = type
//        self.isAdmin = isAdmin
//        self.isMember = isMember
//        self.isAdvertiser = isAdvertiser
//        self.photo50 = photo50
//        self.photo100 = photo100
//        self.photo200 = photo200
//    }
}
