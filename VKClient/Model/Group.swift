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

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let groupsResponse = try? newJSONDecoder().decode(GroupsResponse.self, from: jsonData)

import Foundation

// MARK: - GroupsResponse
class GroupsResponse: Codable {
    let response: ResponseGroups

    init(response: ResponseGroups) {
        self.response = response
    }
}

// MARK: - Response
class ResponseGroups: Codable {
    let count: Int
    let items: [GroupsItem]

    init(count: Int, items: [GroupsItem]) {
        self.count = count
        self.items = items
    }
}

// MARK: - Item
class GroupsItem: Codable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String

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

    init(id: Int, name: String, screenName: String, isClosed: Int, type: String, isAdmin: Int, isMember: Int, isAdvertiser: Int, photo50: String, photo100: String, photo200: String) {
        self.id = id
        self.name = name
        self.screenName = screenName
        self.isClosed = isClosed
        self.type = type
        self.isAdmin = isAdmin
        self.isMember = isMember
        self.isAdvertiser = isAdvertiser
        self.photo50 = photo50
        self.photo100 = photo100
        self.photo200 = photo200
    }
}
