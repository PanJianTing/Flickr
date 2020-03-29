//
//  UICollectionViewExtension.swift
//  Flickr
//
//  Created by panjianting on 2020/3/29.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func reloadDataSmoothly() {
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        
        CATransaction.setCompletionBlock { () -> Void in
            UIView.setAnimationsEnabled(true)
        }
        
        reloadData()
        
        CATransaction.commit()
    }
    
}
