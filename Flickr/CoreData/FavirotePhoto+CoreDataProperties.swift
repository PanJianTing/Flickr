//
//  FavirotePhoto+CoreDataProperties.swift
//  Flickr
//
//  Created by panjianting on 2020/3/29.
//  Copyright © 2020 panjianting. All rights reserved.
//
//

import Foundation
import CoreData


extension FavirotePhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavirotePhoto> {
        return NSFetchRequest<FavirotePhoto>(entityName: "FavirotePhoto")
    }

    @NSManaged public var id: String?
    @NSManaged public var secret: String?
    @NSManaged public var owner: String?
    @NSManaged public var server: String?
    @NSManaged public var farm: Int64
    @NSManaged public var title: String?

}
