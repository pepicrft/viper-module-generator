//
//  TwitterListItem.swift
//  TwitterListGenDemo
//
//  Created by AUTHOR on 24/10/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation
import SwifteriOS

struct TwitterListItem
{
    var body: String?
    var date: NSDate?
    var username: String?
    var avatar: String?
    var identifier: NSNumber?
    
    init(body: String, date: NSDate, username: String, avatar: String, identifier: NSNumber)
    {
        self.body = body
        self.date = date
        self.username = username
        self.avatar = avatar
        self.identifier = identifier
    }
}

// Extension TwitterListItem + Tweet

extension TwitterListItem
{
    init(tweet: Tweet)
    {
        self.body = tweet.body
        self.date = tweet.date
        self.username = tweet.username
        self.avatar = tweet.avatar
        self.identifier = tweet.identifier
    }
    
    func update(inout tweet: Tweet)
    {
        tweet.body = self.body!
        tweet.date = self.date!
        tweet.username = self.username!
        tweet.avatar = self.avatar!
        tweet.identifier = self.identifier!
    }
}

// Extension TwitterListItem + Twwet

extension TwitterListItem
{
    init(jsonDict: Dictionary<String, JSONValue>)
    {
        if (jsonDict["created_at"] != nil && jsonDict["created_at"]!.string != nil) {
            var dateFormater: NSDateFormatter = NSDateFormatter()
            dateFormater.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
            self.date = dateFormater.dateFromString(jsonDict["created_at"]!.string!)
        }
        if (jsonDict["id"] != nil && jsonDict["id"]!.double != nil) { self.identifier = NSNumber(double: jsonDict["id"]!.double!)}
        if (jsonDict["text"] != nil && jsonDict["text"]!.string != nil) { self.body = jsonDict["text"]!.string! }
        let user: Dictionary<String, JSONValue> = jsonDict["user"]!.object!
        if (user["profile_image_url"] != nil && user["profile_image_url"]!.string != nil) { self.avatar = user["profile_image_url"]!.string! }
        if (user["screen_name"] != nil && user["screen_name"]!.string != nil) { self.username = user["screen_name"]!.string! }
    }
}