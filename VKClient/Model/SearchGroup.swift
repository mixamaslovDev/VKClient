//
//  SearchGroup.swift
//  VKClient
//
//  Created by Михаил Маслов on 04.11.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//


import Foundation

// MARK: - SearchGroupResponse
class SearchGroupResponse: Codable {
    let response: ResponseSearchGroup
    
    init(response: ResponseSearchGroup) {
        self.response = response
    }
}

// MARK: - Response
class ResponseSearchGroup: Codable {
    let count: Int
    let items: [ItemSearchGroup]
    
    init(count: Int, items: [ItemSearchGroup]) {
        self.count = count
        self.items = items
    }
}

// MARK: - Item
class ItemSearchGroup: Codable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: TypeEnum
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
    
    init(id: Int, name: String, screenName: String, isClosed: Int, type: TypeEnum, isAdmin: Int, isMember: Int, isAdvertiser: Int, photo50: String, photo100: String, photo200: String) {
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

enum TypeEnum: String, Codable {
    case group = "group"
}
