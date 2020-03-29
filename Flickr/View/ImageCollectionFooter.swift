//
//  ImageCollectionFooter.swift
//  Flickr
//
//  Created by panjianting on 2020/3/29.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

class ImageCollectionFooter: UICollectionReusableView {
    
    var indicatorView : UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.indicatorView = UIActivityIndicatorView(frame: frame);
    
        self.indicatorView.color = UIColor.black
        self.addSubview(self.indicatorView);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
