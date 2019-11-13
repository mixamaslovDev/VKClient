//
//  TabBarContoller.swift
//  VKClient
//
//  Created by Михаил Маслов on 07.11.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    

    
    override func viewDidLoad() {
         super.viewDidLoad()
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.barTintColor = .clear
        tabBar.backgroundColor = .black 
        tabBar.layer.backgroundColor = UIColor.clear.cgColor
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tabBar.bounds
        blurView.autoresizingMask = .flexibleWidth
        blurView.autoresizingMask = .flexibleHeight
        
        tabBar.insertSubview(blurView, at: 0)
    }
    
   
    
}
