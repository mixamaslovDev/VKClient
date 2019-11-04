//
//  FriendsCell.swift
//  VKClient
//
//  Created by Михаил Маслов on 18/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

class FriendsCell: UITableViewCell {
    
    

    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var UserPhoto: AvatarView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            selectionStyle = .none
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            
            nameLabel.text = nil
            userPhoto.image = nil
        }
        
//        override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//            super.setHighlighted(highlighted, animated: animated)
//            backgroundColor = highlighted ? UIColor(hex: 0xF2F2F2) : .white
//            UserPhoto.setViewHighlighted(highlighted, animated: animated)
//        }
    }
