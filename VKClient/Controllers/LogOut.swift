//
//  LogOut.swift
//  VKClient
//
//  Created by Михаил Маслов on 13.11.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit
import Alamofire


class LogOutContoller: UIViewController {
    
    @IBAction func logOutButton(_ sender: UIButton) {
        
        
//        let url = "https://api.vk.com/oauth/logout"
//        
//        Alamofire.request(url, method: .get).responseJSON {(logOut) in
//        }
//        Session.shared.token = nil
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        showEnterError()
        
    }
    
    func showEnterError() {
        let alert = UIAlertController(title: "Выход!", message: "Выполнен выход", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

