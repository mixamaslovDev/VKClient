//
//  String.swift
//  VKClient
//
//  Created by Михаил Маслов on 03.11.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
