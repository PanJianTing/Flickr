//
//  GenericDataSource.swift
//  Flickr
//
//  Created by panjianting on 2020/3/29.
//  Copyright © 2020 panjianting. All rights reserved.
//

import UIKit

class GenericDataSource<T>: NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}
