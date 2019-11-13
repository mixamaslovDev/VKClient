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
        
        
        let url = "https://api.vk.com/oauth/logout"
        
        Alamofire.request(url, method: .get).responseJSON {(logOut) in
            Session.shared.token = nil
    }
    
    
            
//            let friends = try! JSONDecoder().decode(FriendsResponse.self, from: friendsList.data!)
        }
    }

