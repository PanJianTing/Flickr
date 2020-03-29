//
//  CoreDataConnect.swift
//  EasyTransfer
//
//  Created by panjianting on 2020/3/22.
//  Copyright © 2020 PanJianTing. All rights reserved.
//

import UIKit
import CoreData


class CoreDataConnect: NSObject {
    
    var context:NSManagedObjectContext! = nil
    
    init(context:NSManagedObjectContext) {
        self.context = context
    }
    
    func insertFavoritePhoto(photo:Photo) -> Bool {
        let favirotePhoto = NSEntityDescription.insertNewObject(forEntityName: "FavirotePhoto", into: self.context) as! FavirotePhoto;
        favirotePhoto.id = photo.id;
        favirotePhoto.owner = photo.owner;
        favirotePhoto.secret = photo.secret;
        favirotePhoto.server = photo.server;
        favirotePhoto.title = photo.title;
        favirotePhoto.farm = Int64(photo.farm ?? 0);
        
        do{
            try self.context.save();
        }catch{
            fatalError("Insert Photo Fail");
        }
        
        return true;
    }
    

    func getFavPhoto(queryStr:String?) -> [Photo]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavirotePhoto");
        var photos:[Photo] = [];

        if let predicate = queryStr{
            request.predicate = NSPredicate(format: predicate);
        }

        do {
            let fetchResult:[FavirotePhoto]? =  try self.context.fetch(request) as? [FavirotePhoto];
            if let favoritePhotos = fetchResult{
                for favirotePhoto in favoritePhotos {

                    let photo = Photo(id: favirotePhoto.id, owner: favirotePhoto.owner, secret: favirotePhoto.secret, server: favirotePhoto.server, farm: Int(favirotePhoto.farm), title: favirotePhoto.title);
                    photo.isFav = true;
                    photos.append(photo);
                }
            }

        } catch {
            fatalError("\(error)")
        }

        return photos;
    }

    func isFavoritePhoto(photo:Photo) -> Bool{

        guard let id = photo.id, let secret = photo.secret else {
            return false
        }
        
        let quertStr = "id=='\(id)' && secret=='\(secret)'"
        let result = self.getFavPhoto(queryStr: quertStr);

        guard let count = result?.count else {
            return false;
        }
        if (count > 0){
            return true;
        }

        return false;
    }
    
    func deleteFavoritePhoto(photo:Photo) -> Bool{
        
        guard let id = photo.id, let secret = photo.secret else {
            return false
        }
        
        let quertStr = "id=='\(id)' && secret=='\(secret)'"
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavirotePhoto");
        request.predicate = NSPredicate(format: quertStr);

        do {
            let fetchResult:[FavirotePhoto]? =  try self.context.fetch(request) as? [FavirotePhoto];
            if let favoritePhotos = fetchResult{
                for favirotePhoto in favoritePhotos {
                    context.delete(favirotePhoto);
                }
                try context.save();
            }

        } catch {
            fatalError("\(error)")
        }
        
        return true;
    }

}
