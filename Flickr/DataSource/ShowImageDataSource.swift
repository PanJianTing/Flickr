//
//  ShowImageDataSource.swift
//  Flickr
//
//  Created by panjianting on 2020/3/28.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

class ShowImageDataSource : GenericDataSource<Photo>, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var viewModel:SearchViewModel?;
    var isLoading:Bool = false;
    var loadingView:ImageCollectionFooter?
    var isFav = false;
    
    func hideLoadingView() {
        self.loadingView?.isHidden = true;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Count : \(self.data.value.count)");
        return self.data.value.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionCell;
        
        let photo = self.data.value[indexPath.row];
        photo.isFav = (UIApplication.shared.delegate as! AppDelegate).coreData.isFavoritePhoto(photo: photo)
        
        cell.titleLabel.text = photo.title;
        cell.imgID = "\(photo.id ?? "")_\(photo.secret ?? "")_q.jpg"
        cell.imageView.image = UIImage(named: "default_image");
        
        if photo.isFav{
            print("Setting");
            cell.favoriteButton.setImage(fillHeartImg, for: .normal)
        }else{
            cell.favoriteButton.setImage(heartImg, for: .normal)
        }
        
        cell.favoriteButton.tag = indexPath.row;
        cell.favoriteButton.addTarget(viewModel, action: #selector(viewModel?.clickFavoriteBtn(sender:)), for:.touchUpInside);
        
        photo.getImage { (imgID, img) in
                if img != nil, imgID != nil{
                    if imgID == cell.imgID{
                        cell.imageView.image = img
                    }
                    
                }
        }
        
        return cell;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row);
        if indexPath.row == self.data.value.count-2 && !self.isLoading && !self.isFav {
            self.viewModel?.addNowPage();
            self.viewModel?.getSearchResult();
            self.isLoading = true;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading || self.isFav{
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ImageFooterView", for: indexPath) as! ImageCollectionFooter
            loadingView = aFooterView
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.indicatorView.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.indicatorView.stopAnimating()
        }
    }
    
}
