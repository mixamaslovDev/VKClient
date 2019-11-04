//
//  PostCell.swift
//  VKClient
//
//  Created by Михаил Маслов on 10.10.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var postTextLabel: UILabel!
    
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var postStatLabel: UILabel!
    @IBOutlet weak var postAction: UIStackView!
    
}

