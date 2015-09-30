//
//  TwitterListAPIDataManager.swift
//  TwitterListGenDemo
//
//  Created by AUTHOR on 24/10/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation
import SwifteriOS

class TwitterListAPIDataManager: TwitterListAPIDataManagerInputProtocol
{
    init() {}
    
    func downloadTweets(#fromID: Double, amount: Int, completion: (error: NSError?, tweets: [TwitterListItem]?) -> ())
    {
        TwitterClient.sharedInstance.getSearchTweetsWithQuery(TWITTER_SEARCH_TERM, geocode: nil, lang: nil, locale: nil, resultType: "recent", count: amount, until: nil, sinceID: "\(fromID)", maxID: nil, includeEntities: nil, callback: nil, success: { (statuses, searchMetadata) -> Void in
            completion(error: nil, tweets: TwitterListAPIDataManager.twitterListItemsFromJSONArray(statuses))
        }) { (error) -> Void in
            completion(error: error, tweets: nil)
        }
    }
    
    func downloadTweets(#before: NSDate, amount: Int, completion: (error: NSError?, tweets: [TwitterListItem]?) -> ())
    {
        var dateFormater: NSDateFormatter = NSDateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        TwitterClient.sharedInstance.getSearchTweetsWithQuery(TWITTER_SEARCH_TERM, geocode: nil, lang: nil, locale: nil, resultType: "recent", count: amount, until: dateFormater.stringFromDate(before), sinceID: nil, maxID: nil, includeEntities: nil, callback: nil, success: { (statuses, searchMetadata) -> Void in
            completion(error: nil, tweets: TwitterListAPIDataManager.twitterListItemsFromJSONArray(statuses))
            }) { (error) -> Void in
                completion(error: error, tweets: nil)
        }
    }
    
    func downloadTweets(amount: Int, completion: (error: NSError?, tweets: [TwitterListItem]?) -> ())
    {
        TwitterClient.sharedInstance.getSearchTweetsWithQuery(TWITTER_SEARCH_TERM, geocode: nil, lang: nil, locale: nil, resultType: "recent", count: amount, until: nil, sinceID: nil, maxID: nil, includeEntities: nil, callback: nil, success: { (statuses, searchMetadata) -> Void in
                completion(error: nil, tweets: TwitterListAPIDataManager.twitterListItemsFromJSONArray(statuses))
            }) { (error) -> Void in
                completion(error: error, tweets: nil)
        }
    }
    
    class func twitterListItemsFromJSONArray(jsonArray: [JSONValue]?) -> [TwitterListItem]
    {
        if jsonArray == nil {
            return [TwitterListItem]()
        }
        else {
            var list: [TwitterListItem] = [TwitterListItem]()
            for value in jsonArray! {
                var twitterListItem: TwitterListItem = TwitterListItem(jsonDict: value.object!)
                list.append(twitterListItem)
            }
            return list
        }
    }
}