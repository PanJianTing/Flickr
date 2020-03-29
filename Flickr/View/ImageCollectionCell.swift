//
//  ImageCollectionCell.swift
//  Flickr
//
//  Created by panjianting on 2020/3/28.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    
    var imageView : UIImageView!
    var titleLabel : UILabel!
    var favoriteButton : UIButton!
    
    var imgID:String?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: frame.width-10, height: frame.height - 45));
        self.imageView.image = UIImage(named: "default_image");
//        self.imageView.backgroundColor = UIColor.red;
        self.imageView.contentMode = .scaleAspectFit;
        
        self.titleLabel = UILabel(frame: CGRect(x: 5, y: self.imageView.frame.height, width: frame.width-10, height: 35));
        self.titleLabel.textAlignment = .center;
        self.titleLabel.textColor = UIColor.black;
        
        self.favoriteButton = UIButton(frame: CGRect(x: frame.width-45,
                                                     y: frame.height-85,
                                                     width: 40,
                                                     height: 40));
    
        self.favoriteButton.backgroundColor = UIColor.white;
        self.favoriteButton.layer.cornerRadius = 20;
        self.favoriteButton.setImage(UIImage(named: "Heart"), for: .normal);
        
        self.addSubview(self.imageView);
        self.addSubview(self.titleLabel);
        self.addSubview(self.favoriteButton);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
