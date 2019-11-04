//
//  UIImage.swift
//  VKClient
//
//  Created by Михаил Маслов on 26/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

extension UIImage {
    
    static var empty: UIImage {
        return UIGraphicsImageRenderer(size: CGSize.zero).image { _ in }
    }
        
}
