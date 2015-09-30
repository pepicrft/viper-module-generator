//
//  TwitterListLocalDataManager.swift
//  TwitterListGenDemo
//
//  Created by AUTHOR on 24/10/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation
import CoreData

class TwitterListLocalDataManager: TwitterListLocalDataManagerInputProtocol, NSFetchedResultsControllerDelegate
{
    init() {}
    var fetchedResultsController: NSFetchedResultsController?
    
    var interactor: TwitterListLocalDataManagerOutputProtocol?
    
    func logoutUser()
    {
        logoutFunction()
    }
    
    func loadLocalTweets()
    {
        self.fetchedResultsController = Tweet.all().sorted(by: "date", ascending: false).fetchedResultsController(nil)
        self.fetchedResultsController!.delegate = self
        var error: NSError?
        self.fetchedResultsController!.performFetch(&error)
        if error != nil { println("Error initializing fetched results controller")}
    }
    
    func mostRecentTweetIdentifier() -> Double?
    {
        let foundTweets: [AnyObject]?  = Tweet.all().sorted(by: "identifier", ascending: true).find() as [AnyObject]?
        let tweet: Tweet? = (foundTweets as [Tweet]).last?
        return tweet?.identifier.doubleValue
    }
    
    func oldestTweetDate() -> NSDate?
    {
        let foundTweets: [AnyObject]?  = Tweet.all().sorted(by: "identifier", ascending: true).find() as [AnyObject]?
        let tweet: Tweet? = (foundTweets as [Tweet]).first?
        return tweet?.date
    }
    
    func persist(#tweets: [TwitterListItem])
    {
        SugarRecord.operation(inBackground: true, stackType: SugarRecordStackType.SugarRecordStackTypeCoreData) { (context) -> () in
            context.beginWriting()
            var allTweets: [Tweet]? = Tweet.all().find(inContext: context) as [Tweet]?
            if (allTweets == nil) { allTweets = [Tweet]() }
            for twitterListItem: TwitterListItem in tweets {
                let tweetAlreadyExists: Bool = allTweets!.filter({ (tweet: Tweet) -> Bool in
                    return tweet.identifier.isEqual(twitterListItem.identifier!)
                }).count != 0
                if (tweetAlreadyExists) { continue }
                var tweet: Tweet = Tweet.create(inContext: context) as Tweet
                tweet.username = twitterListItem.username!
                tweet.avatar = twitterListItem.avatar!
                tweet.date = twitterListItem.date!
                tweet.identifier = twitterListItem.identifier!
                tweet.body = twitterListItem.body!
            }
            context.endWriting()
        }
    }
    
    func numberOfTweets(inSection section: Int) -> Int
    {
        if (self.fetchedResultsController != nil) {
            let s = (self.fetchedResultsController!.sections as? [NSFetchedResultsSectionInfo])!
            return s[section].numberOfObjects
        }
        return 0
    }
    
    func numberOfSections() -> Int
    {
        if (self.fetchedResultsController != nil) { return self.fetchedResultsController!.sections!.count}
        return 0
    }
    
    func twitterListItemAtIndexPath(indexPath: NSIndexPath) -> TwitterListItem
    {
        let object: AnyObject = self.fetchedResultsController!.objectAtIndexPath(indexPath)
        return TwitterListItem(tweet: object as Tweet)
    }
    
    
    //MARK: NSFetchedResultsControllerProtocol
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?)
    {
        self.interactor?.tweetDidChange(TwitterListChangeType.from(type), tweet: TwitterListItem(tweet: anObject as Tweet), atIndexPath: indexPath?, newIndexPath: newIndexPath?)
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType)
    {
        self.interactor?.tweetSectionsDidChange(TwitterListChangeType.from(type), atIndex: sectionIndex)
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController)
    {
        self.interactor?.tweetsListWillChange()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController)
    {
        self.interactor?.tweetsListDidChange()
    }
}