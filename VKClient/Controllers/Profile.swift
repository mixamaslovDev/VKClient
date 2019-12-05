//
//  PhotosView.swift
//  VKClient
//
//  Created by Михаил Маслов on 14/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit
import Kingfisher

class PhotosTablesView: UICollectionViewController {
    
    private let reuseIdentifier = "photoCell"
    
    var photosUser: UIImageView!
    var usersPhoto = [PhotoItem]()
   
        override func viewDidLoad() {
        super.viewDidLoad()
            vk.getPhotos { [weak self] photos in
            self?.usersPhoto = photos.response.items
            self?.collectionView.reloadData()
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersPhoto.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        let url = URL(string: usersPhoto[indexPath.row].photo604)
        cell.photoImage.kf.setImage(with: url, options: [.cacheOriginalImage])
        return cell
    }
}
