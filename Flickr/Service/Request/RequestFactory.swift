//
//  RequestFactory.swift
//  Flickr
//
//  Created by panjianting on 2020/3/28.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

final class RequestFactory {
    
    enum Method: String{
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    static func request(method:Method, url:URL) -> URLRequest{
        var request = URLRequest(url: url);
        request.httpMethod = method.rawValue;
        return request;
    }
    

}
