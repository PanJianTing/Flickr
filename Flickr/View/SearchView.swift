//
//  SearchView.swift
//  Flickr
//
//  Created by panjianting on 2020/3/28.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    var keyTextField:UITextField!
    var perPageTextField:UITextField!
    var searchButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setKeyTextField(frame: frame);
        setPerPageTextField(frame: frame);
        setSearchButton(frame: frame);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setKeyTextField(frame:CGRect){
        self.keyTextField = UITextField(frame: CGRect(x: 20,
                                                      y: 0,
                                                      width: frame.width - 40,
                                                      height: 40));
        
        self.keyTextField.attributedPlaceholder = NSAttributedString(string:"欲搜尋內容", attributes:[NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        
        self.keyTextField.textColor = UIColor.black;
        
        self.keyTextField.layer.borderWidth = 1;
        self.keyTextField.layer.cornerRadius = 6;
        self.keyTextField.layer.borderColor = UIColor.gray.cgColor;
        
        
        self.keyTextField.keyboardType = .emailAddress;
        self.keyTextField.returnKeyType = .done;
        
        let keyLeftView: UIView = UIView(frame: CGRect(x: 0,
                                                           y: 0,
                                                           width: 10,
                                                           height: 10));
        self.keyTextField.leftViewMode = .always
        self.keyTextField.leftView = keyLeftView
        
        self.keyTextField.delegate = self;
        
        self.addSubview(self.keyTextField);
    }
    
    private func setPerPageTextField(frame:CGRect){
        self.perPageTextField = UITextField(frame: CGRect(x: 20,
                                                          y: self.keyTextField.frame.origin.y+60,
                                                         width: frame.width - 40,
                                                         height: 40))
        
        self.perPageTextField.attributedPlaceholder = NSAttributedString(string:"每頁呈現數量", attributes:[NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        
        self.perPageTextField.textColor = UIColor.black;
        
        self.perPageTextField.keyboardType = .numberPad;
        self.perPageTextField.returnKeyType = .done;
        
        self.perPageTextField.layer.borderWidth = 1;
        self.perPageTextField.layer.cornerRadius = 6;
        self.perPageTextField.layer.borderColor = UIColor.gray.cgColor;
        let perPageleftView: UIView = UIView(frame: CGRect(x: 0,
                                                           y: 0,
                                                           width: 10,
                                                           height: 10));
        self.perPageTextField.leftViewMode = .always
        self.perPageTextField.leftView = perPageleftView
        
        self.setPerPageTextFieldToolBar(frame: frame);
        
        self.perPageTextField.delegate = self;
        self.addSubview(self.perPageTextField);
    }
    
    private func setSearchButton(frame:CGRect){
        self.searchButton = UIButton(frame: CGRect(x: 20,
                                                   y: self.perPageTextField.frame.origin.y+60,
                                                   width: frame.width - 40,
                                                   height: 40));
        
        self.searchButton.setTitle("搜尋", for: .normal)
        self.searchButton.setTitleColor(UIColor.white, for: .normal);
        self.searchButton.backgroundColor = UIColor.lightGray;
        self.searchButton.layer.cornerRadius = 20;
        self.searchButton.isEnabled = false;
        self.addSubview(self.searchButton);
    }
    
    private func setPerPageTextFieldToolBar(frame:CGRect){
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 30));
        
        let flexSpace = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil);
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hiddenKeyBoard))
        
        toolBar.setItems([flexSpace, doneButton], animated: false);
        toolBar.sizeToFit();
        
        self.perPageTextField.inputAccessoryView = toolBar;
    }
}
