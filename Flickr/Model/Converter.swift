//
//  Converter.swift
//  Flickr
//
//  Created by panjianting on 2020/3/28.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

struct Convert {
    let photos:ConverterPhotos
    let stat:String
}

extension Convert : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Convert, ErrorResult> {
        if let photos = dictionary["photos"] as? [String: AnyObject],
            let stat = dictionary["stat"] as? String {
            
            switch ConverterPhotos.parseObject(dictionary: photos) {
            case .failure(_):
                return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
            case .success(let newModel):
                let conversion = Convert(photos: newModel, stat: stat)
                return Result.success(conversion)
            }
        
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }
}
