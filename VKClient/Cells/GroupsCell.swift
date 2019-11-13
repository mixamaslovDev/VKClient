//
//  GroupsCell.swift
//  VKClient
//
//  Created by Михаил Маслов on 19/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

class GroupsCell: UITableViewCell {
    
    
    @IBOutlet weak var groupPhoto: AvatarView!
    
    @IBOutlet weak var nameGroup: UILabel!

    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameGroup.text = nil
//        groupPhoto.image = nil
    }
}
