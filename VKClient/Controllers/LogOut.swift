//
//  LogOut.swift
//  VKClient
//
//  Created by Михаил Маслов on 13.11.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit
import WebKit
import RealmSwift

class LogOutContoller: UIViewController {
    
    @IBAction func logOut(_ sender: UIButton)  {
        alertExit()
    }
    
    func alertExit() {
        
        let alert = UIAlertController(title: "Выход из аккаунта", message: "Вы уверены, что хотите выйти?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Выйти", style: UIAlertAction.Style.default, handler: { action in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "logout", sender: self);
            }
            self.clear(cache: true, cookies: true)
            Session.shared.token = nil
            Session.shared.userId = nil
            RealmDataBase.shared.deleteData()
            self.clean()

        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
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
    
    func clean() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
}

