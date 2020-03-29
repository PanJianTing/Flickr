//
//  DynamicValue.swift
//  Flickr
//
//  Created by panjianting on 2020/3/29.
//  Copyright © 2020 panjianting. All rights reserved.
//

import Foundation

class DynamicValue<T> {
    
    typealias CompletionHandler = ((T) -> Void)
    
    var value:T{
        didSet{
            self.notify();
        }
    }
    
    private var observers = [String : CompletionHandler]()
    
    init(_ value:T) {
        self.value = value
    }
    
    public func addObserver(_ observer:NSObject, completionHandler:@escaping CompletionHandler){
        observers[observer.description] = completionHandler;
    }

    public func addAndNotify(_ observer:NSObject, completionHandler:@escaping CompletionHandler){
        observers[observers.description] = completionHandler;
        self.notify();
        
    }
    
    private func notify(){
        observers.forEach({ $0.value(value) })
    }
    
    deinit {
        observers.removeAll()
    }
}
