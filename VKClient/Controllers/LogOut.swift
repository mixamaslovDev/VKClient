//
//  LogOut.swift
//  VKClient
//
//  Created by Михаил Маслов on 13.11.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

class LogOutContoller: UIViewController {
    
    
    @IBAction func logOut(_ sender: UIButton)  {
        clear(cache: true, cookies: true)
        Session.shared.token = nil
        Session.shared.userId = nil
        
    }
    
    func clear(cache: Bool, cookies: Bool) {
        if cache { clearCache() }
        if cookies { clearCookies() }
    }

    fileprivate func clearCache() {
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        
    }

    fileprivate func clearCookies() {
        let cookieStorage = HTTPCookieStorage.shared

        guard let cookies = cookieStorage.cookies else { return }

        for cookie in cookies {
            cookieStorage.deleteCookie(cookie)
        }
    }
    
    
}

