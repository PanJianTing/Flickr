//
//  SearchView + UITextFieldDelegate.swift
//  Flickr
//
//  Created by panjianting on 2020/3/28.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

extension SearchView : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        self.endEditing(true)

        return true;
    }
    
    @objc func hiddenKeyBoard(){
        self.endEditing(true);
    }
  
}
