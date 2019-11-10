//
//  Photo.swift
//  VKClient
//
//  Created by Михаил Маслов on 01.11.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import Foundation

// MARK: - PhotosResponse
class PhotosResponse: Codable {
    let response: ResponsePhoto

    init(response: ResponsePhoto) {
        self.response = response
    }
}

// MARK: - Response
class ResponsePhoto: Codable {
    let count: Int
    let items: [PhotoItem]

    init(count: Int, items: [PhotoItem]) {
        self.count = count
        self.items = items
    }
}

// MARK: - Item
class PhotoItem: Codable {
    let id, albumID, ownerID: Int
    let photo75, photo130, photo604: String
    let photo807, photo1280, photo2560: String?
    let width, height: Int
    let text: String
    let date, postID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case ownerID = "owner_id"
        case photo75 = "photo_75"
        case photo130 = "photo_130"
        case photo604 = "photo_604"
        case photo807 = "photo_807"
        case photo1280 = "photo_1280"
        case photo2560 = "photo_2560"
        case width, height, text, date
        case postID = "post_id"
    }

    init(id: Int, albumID: Int, ownerID: Int, photo75: String, photo130: String, photo604: String, photo807: String?, photo1280: String?, photo2560: String?, width: Int, height: Int, text: String, date: Int, postID: Int) {
        self.id = id
        self.albumID = albumID
        self.ownerID = ownerID
        self.photo75 = photo75
        self.photo130 = photo130
        self.photo604 = photo604
        self.photo807 = photo807
        self.photo1280 = photo1280
        self.photo2560 = photo2560
        self.width = width
        self.height = height
        self.text = text
        self.date = date
        self.postID = postID
    }
}

