//
//  ConverterPhotos.swift
//  Flickr
//
//  Created by panjianting on 2020/3/28.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit


struct ConverterPhotos {
    let page : Int
    let pages : Int
    let perpage : Int
    let total : String
    let photos : [Photo]
}

extension ConverterPhotos : Parceable{
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<ConverterPhotos, ErrorResult> {
        if let page = dictionary["page"] as? Int,
            let pages = dictionary["pages"] as? Int,
            let perpage = dictionary["perpage"] as? Int,
            let total = dictionary["total"] as? String,
            let photos = dictionary["photo"] as? [AnyObject]{
            
            var finalPhotos : Array<Photo> = [];
            for object in photos{
                if let dictionary = object as? [String : AnyObject]{
                    switch Photo.parseObject(dictionary: dictionary) {
                    case .failure(_):
                        continue
                    case .success(let newModel):
                        finalPhotos.append(newModel);
                        break;
                    }
                }
            }
            
            let photoConverter = ConverterPhotos(page: page, pages: pages, perpage: perpage, total: total, photos: finalPhotos)
            
            return Result.success(photoConverter)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse Photo Converter"))
        }
    }
}
