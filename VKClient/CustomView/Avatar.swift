//
//  View.swift
//  VKClient
//
//  Created by Михаил Маслов on 23/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit
    
class AvatarView: UIView {
        
        @IBInspectable var shadowColor: UIColor = .gray
        @IBInspectable var shadowRadius: CGFloat = 0
        @IBInspectable var shadowOpacity: Float = 1
        
        @IBInspectable var image: UIImage = UIImage.empty {
            didSet {
                setupView()
            }
        }
        
        private let shadowView = UIView()
        private let imageView = UIImageView()
        
        override func awakeFromNib() {
            super.awakeFromNib()
            setupView()
        }
        
        func setupView() {
            removeSubviews()
            setupShadowView()
            setupImageView()
        }
        
        func removeSubviews() {
            shadowView.removeFromSuperview()
            imageView.removeFromSuperview()
        }
        
        func setupShadowView() {
            shadowView.backgroundColor = .white
            shadowView.layer.shadowColor = shadowColor.cgColor
            shadowView.layer.shadowRadius = shadowRadius
            shadowView.layer.shadowOpacity = shadowOpacity
            shadowView.layer.masksToBounds = false
            addSubview(shadowView)
        }
        
        func setupImageView() {
            imageView.image = image
            imageView.layer.masksToBounds = true
            imageView.layer.borderColor = UIColor.gray.cgColor
            imageView.layer.borderWidth = 1
            addSubview(imageView)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            shadowView.frame = self.bounds
            shadowView.layer.cornerRadius = shadowView.bounds.width / 2
            
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

