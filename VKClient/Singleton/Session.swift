//
//  Session.swift
//  VKClient
//
//  Created by Михаил Маслов on 23.10.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import Foundation


class Session {
    private init() {}
    static let shared = Session()
    
    var token: String?
    var userId: String?
    
}
 let vk = VkApi()
