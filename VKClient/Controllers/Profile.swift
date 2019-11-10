//
//  PhotosView.swift
//  VKClient
//
//  Created by Михаил Маслов on 14/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

class PhotosTablesView: UICollectionViewController {
    
    private let reuseIdentifier = "photoCell"
    
    var photosUser: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        cell.photoImage = photosUser
        
        return cell
    }
}
