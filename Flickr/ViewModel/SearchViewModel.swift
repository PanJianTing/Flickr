//
//  SearchViewModel.swift
//  Flickr
//
//  Created by panjianting on 2020/3/28.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

class SearchViewModel: NSObject {

    private var key:String!
    private var perPage:Int!
    private var nowPage:Int!
    
    weak var searchAPI:FlickrAPI?
    weak var dataSource:GenericDataSource<Photo>?
    
    var onErrorHandling : ((ErrorResult?) -> Void)?
    var onNoData : ((Bool)->Void)?
    var favoriteSuccess : ((String)->Void)?
    
    init(key:String, perPage:Int, dataSource:GenericDataSource<Photo>?) {
        self.key = key;
        self.perPage = perPage;
        self.searchAPI = FlickrAPI.shared;
        self.dataSource = dataSource
        self.nowPage = 1;
    }
    
    
    func getSearchResult(){
        guard let service = searchAPI else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        service.getPhoto(text: self.key, page: self.nowPage, perPage: self.perPage) { (result) in
            sleep(1);
            DispatchQueue.main.async {
                switch result{
                case .success(let convert):
                    guard convert.photos.photos.count != 0 else {
                        if self.dataSource?.data.value.count == 0 {
                            self.onNoData?(true)
                        }else{
                            self.onNoData?(false)
                        }
                        
                        return;
                    }
                    self.dataSource?.data.value.append(contentsOf: convert.photos.photos);
                    if self.dataSource?.data.value.count == Int(convert.photos.total) {
                        self.onNoData?(false)
                    }
                    break;
                case.failure(let error):
                    self.onErrorHandling?(error);
                    break;
                }
            }
        }
    }
    
    func getFavoritePhoto() {
        DispatchQueue.main.async {
            guard let favoritePhotos = (UIApplication.shared.delegate as! AppDelegate).coreData.getFavPhoto(queryStr: nil) else {
                return
            }
            
            self.dataSource?.data.value = favoritePhotos
        }
    }
    
    func addNowPage()  {
        self.nowPage += 1;
    }
    
    
    @objc func clickFavoriteBtn(sender:UIButton){
        
        if let photo = self.dataSource?.data.value[sender.tag] {
            if !photo.isFav{
                let isSuccess = (UIApplication.shared.delegate as! AppDelegate).coreData.insertFavoritePhoto(photo: photo)
                if isSuccess{
                    self.favoriteSuccess?("收藏成功");
                    sender.setImage(fillHeartImg, for:.normal)
                    photo.isFav = true;
                }else{
                    self.favoriteSuccess?("收藏失敗");
                }
            }else{
                // TODO:刪資料
                let isSuccess = (UIApplication.shared.delegate as! AppDelegate).coreData.deleteFavoritePhoto(photo: photo)
                if isSuccess{
                    self.favoriteSuccess?("移除收藏成功");
                    sender.setImage(heartImg, for:.normal)
                    photo.isFav = false;
                }else{
                    self.favoriteSuccess?("移除收藏成功失敗");
                }
            }
        }
    }

}
