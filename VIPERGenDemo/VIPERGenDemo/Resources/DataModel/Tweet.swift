//
//  Tweet.swift
//  VIPERGenDemo
//
//  Created by Pedro Piñera Buendia on 13/11/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation
import CoreData
 
@objc(Tweet)
class Tweet: NSManagedObject {

    @NSManaged var avatar: String
    @NSManaged var body: String
    @NSManaged var date: NSDate
    @NSManaged var identifier: NSNumber
    @NSManaged var username: String

}
