//
//  LikeContol.swift
//  VKClient
//
//  Created by Михаил Маслов on 28/09/2019.
//  Copyright © 2019 Михаил Маслов. All rights reserved.
//

import UIKit

class LikeControl: UIControl {
    
    public var isLiked: Bool = false
    let heartImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView() {
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        heartImageView.isUserInteractionEnabled = true
        heartImageView.addGestureRecognizer(tapGR)
        
        addSubview(heartImageView)
        heartImageView.image = UIImage(named: "heart_empty")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        heartImageView.frame = bounds
    }
    
    @objc func likeTapped() {
        isLiked.toggle()
        heartImageView.image = isLiked ? UIImage(named: "heart_filled") : UIImage(named: "heart_empty")
        sendActions(for: .valueChanged)
    }
    
}
