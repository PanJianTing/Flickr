//
//  URLConnection.swift
//  Flickr
//
//  Created by panjianting on 2020/3/28.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

class URLConnection: NSObject {
    
    let urlString : String;
    
    init(url : String) {
        urlString = url;
    }
    
    func requestWithURL(completion: @escaping (Result<Data, ErrorResult>) -> Void){
        let urlComponent = URLComponents(string: urlString)!;
        
        guard let queryedURL = urlComponent.url else {
            return
        }
        
        let request = URLRequest(url: queryedURL);
        
        fetchedDataByDataTask(from: request, completion: completion);
    }
    
    
    private func fetchedDataByDataTask(from resquest: URLRequest, completion: @escaping (Result<Data, ErrorResult>) -> Void){
        let task = URLSession.shared.dataTask(with: resquest){
            (data, response, error) in
            
            if error != nil{
                print(error as Any)
            }else{
                if let error = error{
                    completion(Result.failure(.custom(string: "Http Error " + error.localizedDescription)))
                    return;
                }
                
                guard let data = data else {
                    completion(Result.failure(.custom(string: "Data is nil")))
                    return
                }
                
                completion(Result.success(data));
            }
        }
        
        task.resume();
    }
    
}
