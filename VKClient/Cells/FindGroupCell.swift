//
//  FindGroupCell.swift
//  VKClient
//
//  Created by Михаил Маслов on 19/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

class FindGroupCell: UITableViewCell {
    
    @IBOutlet weak var imageFindGroup: AvatarView!
    @IBOutlet weak var nameFindGroup: UILabel!
//     @IBOutlet weak var imageFindGroup: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameFindGroup.text = nil
//        imageFindGroup.image = nil
    }
}
