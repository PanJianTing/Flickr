//
//  FlickrAPI.swift
//  Flickr
//
//  Created by panjianting on 2020/3/28.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

class FlickrAPI: NSObject {
    
    static let shared = FlickrAPI();
    
    private let host = "https://jsonplaceholder.typicode.com"
    private let photo = "/photos"
    
   private let flickrSearchURL = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=6680f2d8bf8a5426520040f863d85ba3&format=json&nojsoncallback=1"
    
    func getPhoto(text:String, page:Int, perPage:Int, completion: @escaping (Result<Convert, ErrorResult>) -> Void ) {
    
//        text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed);
        let url = flickrSearchURL + "&text=\(text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&per_page=\(perPage)&page=\(page)";
        
        print(url);
        
        let urlConnection:URLConnection = URLConnection(url: url);
        
        urlConnection.requestWithURL { (result) in
            switch result {
            case .success(let data):
                ParserHelper.parse(data: data, completion: completion);
                break;
            case .failure(_):
                break;
            }
        }
    }
}
