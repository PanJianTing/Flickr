//
//  Photo.swift
//  Flickr
//
//  Created by panjianting on 2020/3/28.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

final class Photo: NSObject, Parceable {
    var id : String?
    var owner : String?
    var secret : String?
    var server : String?
    var farm : Int?
    var title : String?
    var isFav : Bool = false;
    
    init(id:String?, owner:String?, secret:String?, server:String?, farm:Int?, title:String?) {
        super.init()
        self.id = id;
        self.owner = owner;
        self.secret = secret;
        self.server = server;
        self.farm = farm;
        self.title = title;
        self.isFav = false
    }
    
    func getImage(completion:@escaping (String?, UIImage?) -> Void) {
        
        guard let farm = self.farm, let server = self.server, let id = self.id, let secret = self.secret else {
            completion(nil, nil);
            return
        }
        
        let imgStr = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_q.jpg"
        
        guard let imgURL = URL(string: imgStr) else {
            completion(nil, nil);
            return;
        }
        
        print("IMG URL \(imgStr)");
        
        let tempDirectory = FileManager.default.temporaryDirectory;
        
        let imgID = imgURL.lastPathComponent
        
        let imageFileUrl = tempDirectory.appendingPathComponent(imgID);
        
        if FileManager.default.fileExists(atPath: imageFileUrl.path) {
            print("Get File")
            let image = UIImage(contentsOfFile: imageFileUrl.path)!;
            completion(imgID,image)
        } else {
            print("Get Network")
            let task = URLSession.shared.dataTask(with: imgURL) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    try? data.write(to: imageFileUrl)
                    DispatchQueue.main.async {
                        completion(imgID,image);
                    }
                    
                }
            }
            task.resume()
        }
        
        
    }
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Photo, ErrorResult> {
        if let id = dictionary["id"] as? String,
            let owner = dictionary["owner"] as? String,
            let secret = dictionary["secret"] as? String,
            let server = dictionary["server"] as? String,
            let farm = dictionary["farm"] as? Int,
            let title = dictionary["title"] as? String{
            
            let photo = Photo(id: id, owner: owner, secret: secret, server: server, farm: farm, title: title)
            return Result.success(photo)
            
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }

}


