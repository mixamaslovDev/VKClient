//
//  photoCell.swift
//  VKClient
//
//  Created by Михаил Маслов on 18/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
        photoImage.image = nil
    }
    
}
