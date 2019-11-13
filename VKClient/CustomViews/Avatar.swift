//
//  View.swift
//  VKClient
//
//  Created by Михаил Маслов on 23/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit
    
class AvatarView: UIView {
        
        
    @IBInspectable var image: UIImageView = UIImageView() {
            didSet {
                setupView()
            }
        }
        
        private var imageView = UIImageView()
        
        override func awakeFromNib() {
            super.awakeFromNib()
            setupView()
        }
        
        func setupView() {
            removeSubviews()
            setupImageView()
        }
        
        func removeSubviews() {
            imageView.removeFromSuperview()
        }
        
        func setupImageView() {
            imageView = image
            imageView.layer.masksToBounds = true
            imageView.layer.borderColor = UIColor.gray.cgColor
            imageView.layer.borderWidth = 1
            addSubview(imageView)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            imageView.frame = self.bounds
            imageView.layer.cornerRadius = imageView.bounds.width / 2
        }
        
        func setViewHighlighted(_ higlighted: Bool, animated: Bool) {
            let color = higlighted ? UIColor(hex: 0xF2F2F2) : UIColor.white
            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundColor = color
                }
            } else {
                backgroundColor = color
            }
        }
    }

