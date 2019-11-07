//
//  PhotosScroll.swift
//  VKClient
//
//  Created by Михаил Маслов on 15.10.2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

class AllPhotos : UIViewController {
    
    @IBOutlet weak var photosScroll: UIScrollView!
    var photos = [PhotoItem]()
    var images = [UIImage?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vk.getPhotos { [weak self] photos in
            self?.photos = photos.response.items
            self?.photosScroll.reloadInputViews()
        }
        
        images = allImages
        
        setupImages(images as! [UIImage])
        
        
    }
    
    
    func setupImages(_ images: [UIImage]){
        
        for i in 0..<images.count {
            
            let imageView = UIImageView()
            imageView.image = images[i]
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: photosScroll.frame.width, height: photosScroll.frame.height)
            imageView.contentMode = .scaleAspectFit
            
            photosScroll.contentSize.width = photosScroll.frame.width * CGFloat(i + 1)
            photosScroll.addSubview(imageView)
            
        }
        
    }
    
}
