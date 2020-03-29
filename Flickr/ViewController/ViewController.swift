//
//  ViewController.swift
//  Flickr
//
//  Created by panjianting on 2020/3/28.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var fullScreenSize : CGSize! {
        return ViewUtil.getFullScreenSize(vc: self)
    }
    
    var searchView:SearchView!;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSearchView()
        self.setViewTouch()
        self.title = "搜尋輸入頁"
        // Do any additional setup after loading the view.
    }
    
    
    // MARK:ViewComponent
    
    private func setSearchView() {
        self.searchView = SearchView(frame: CGRect(x: 0, y: self.fullScreenSize.height/2-80, width: self.fullScreenSize.width, height: 160))
        self.searchView.keyTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.searchView.perPageTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.searchView.searchButton.addTarget( self, action: #selector(clickSearchButton), for:.touchUpInside)
        self.view.addSubview(self.searchView);
    }
    
    private func setViewTouch(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hiddenKeyBoard));
        tap.cancelsTouchesInView = false;
        self.view.addGestureRecognizer(tap);
        
    }
    
    @objc func textFieldDidChange() {
        
        if (self.searchView.keyTextField.text != "" && self.searchView.perPageTextField.text != ""){
            self.searchView.searchButton.backgroundColor = UIColor.blue
            self.searchView.searchButton.isEnabled = true;
        }else{
            self.searchView.searchButton.backgroundColor = UIColor.lightGray;
            self.searchView.searchButton.isEnabled = false;
        }
    }
    
    @objc func clickSearchButton() {
        
        let key = self.searchView.keyTextField.text ?? ""
        let perPage = self.searchView.perPageTextField.text ?? ""
        let showImageVC = ShowImageViewController();
        
        showImageVC.isFav = false;
        showImageVC.key = key
        showImageVC.perPage = Int(perPage)
        
        self.navigationController?.pushViewController(showImageVC, animated: true);
    }
    
    @objc func hiddenKeyBoard(){
        self.view.endEditing(true);
    }


}

