//
//  ShowImageViewController.swift
//  Flickr
//
//  Created by panjianting on 2020/3/28.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController{

    var fullScreenSize : CGSize! {
        return ViewUtil.getFullScreenSize(vc: self)
    }
    
    var navigationBarHeight : CGFloat! {
        return ViewUtil.getNavigationHeight(navigationViewController: self.navigationController);
    }
    
    var perPage:Int?
    var key:String?
    
    var isFav = false;
    var dataSource = ShowImageDataSource();
    var viewModel:SearchViewModel?
    
    
    var imageCollectionView:UICollectionView!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = self.setCollectionViewLayout();
        self.setCollectionView(layout: layout);
        
        self.viewModel = SearchViewModel(key: key ?? "", perPage: perPage ?? 10, dataSource: self.dataSource);
        
        self.viewModel?.onErrorHandling = {[weak self] error in
            let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
        
        self.viewModel?.onNoData = { [weak self] isShow in
            if isShow {
                let controller = UIAlertController(title: "注意", message: "抱歉，沒有任何搜尋結果", preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "確定", style: .cancel, handler: { (action) in
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true);
                    }
                }))
                self?.present(controller, animated: true, completion:nil)
            }
            
            self?.dataSource.loadingView?.isHidden = true;
        }
        
        self.viewModel?.favoriteSuccess = { [weak self] messgae in
            let controller = UIAlertController(title: "恭喜", message: messgae, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "確定", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
            if self?.isFav ?? false {
                self?.viewModel?.getFavoritePhoto();
            }
        }
        
        self.dataSource.viewModel = self.viewModel;
        self.dataSource.isFav = self.isFav;
        
        self.dataSource.data.addAndNotify(self) { [weak self] _ in
            self?.dataSource.isLoading = false;
            self?.imageCollectionView.reloadData();
        }
        
        if (!isFav){
            self.viewModel?.getSearchResult();
            self.title = "搜尋結果 \(self.key ?? "")"
        }else{
            self.title = "我的最愛"
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.isFav {
            self.viewModel?.getFavoritePhoto();
        }else{
            self.imageCollectionView.reloadData();
        }
    }
    
    
    private func setCollectionViewLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout();
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 0);
        
        layout.itemSize = CGSize(width: self.fullScreenSize.width/2, height: self.fullScreenSize.width/2);
        
        if(!isFav){
            layout.footerReferenceSize = CGSize(width: self.fullScreenSize.width, height: 40);
        }
        
        return layout;
    }
    
    private func setCollectionView(layout:UICollectionViewFlowLayout){
        self.imageCollectionView = UICollectionView(frame: CGRect(x: 0, y: self.navigationBarHeight, width: self.fullScreenSize.width, height: self.fullScreenSize.height-self.navigationBarHeight),collectionViewLayout: layout);
        
        self.imageCollectionView.backgroundColor = UIColor.white;
        
        self.imageCollectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: "ImageCell");
        self.imageCollectionView.register(ImageCollectionFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ImageFooterView")
        
        self.imageCollectionView.delegate = self.dataSource;
        self.imageCollectionView.dataSource = self.dataSource;
        
        self.view.addSubview(self.imageCollectionView);
    }
    
}
