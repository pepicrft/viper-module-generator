//
//  TwitterListInteractor.swift
//  TwitterListGenDemo
//
//  Created by AUTHOR on 24/10/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation

class TwitterListInteractor: TwitterListInteractorInputProtocol, TwitterListLocalDataManagerOutputProtocol
{
    weak var presenter: TwitterListInteractorOutputProtocol?
    var APIDataManager: TwitterListAPIDataManagerInputProtocol?
    var localDatamanager: TwitterListLocalDataManagerInputProtocol?
    var downloading: Bool = false
    
    init() {}
    
    
    // MARK: - TwitterListInteractorInputProtocol
    
    func logoutUser(completion: (error: NSError?) -> ())
    {
        self.localDatamanager?.logoutUser()
        completion(error: nil)
    }
    
    func refreshTweets(completion: (error: NSError?) -> ())
    {
        if downloading {
            completion(error: nil)
            return
        }
        downloading = true
        let mostRecentIdentifier: Double? = self.localDatamanager?.mostRecentTweetIdentifier()
        if mostRecentIdentifier != nil {
            self.APIDataManager?.downloadTweets(fromID: mostRecentIdentifier!, amount: 100, completion: { [weak self] (error, tweets) -> () in
                self?.downloading = false
                if error != nil {
                    completion(error: error)
                }
                else if tweets != nil{
                    self?.localDatamanager?.persist(tweets: tweets!)
                    completion(error: nil)
                }
            })
        }
        else {
            self.APIDataManager?.downloadTweets(100, completion: { [weak self] (error, tweets) -> () in
                self?.downloading = false
                if error != nil {
                    completion(error: error)
                }
                else if tweets != nil{
                    self?.localDatamanager?.persist(tweets: tweets!)
                    completion(error: nil)
                }
            })
        }
    }
    
    func loadLocalTweets()
    {
        self.localDatamanager?.loadLocalTweets()
    }
    
    func downloadOlderTweets(completion: (error: NSError?) -> ())
    {
        if downloading {
            completion(error: nil)
            return
        }
        downloading = true
        let oldestDate: NSDate? = self.localDatamanager?.oldestTweetDate()
        if (oldestDate != nil) {
            self.APIDataManager?.downloadTweets(before: oldestDate!, amount: 100, completion: { [weak self] (error, tweets) -> () in
                self?.downloading = false
                if error != nil {
                    completion(error: error)
                }
                else if tweets != nil{
                    self?.localDatamanager?.persist(tweets: tweets!)
                }
            })
        }
        else {
            self.APIDataManager?.downloadTweets(100, completion: { [weak self] (error, tweets) -> () in
                self?.downloading = false
                if error != nil {
                    completion(error: error)
                }
                else if tweets != nil{
                    self?.localDatamanager?.persist(tweets: tweets!)
                    completion(error: nil)
                }
            })
        }
        
    }
    
    func numberOfTweets(inSection section: Int) -> Int
    {
        if localDatamanager != nil  { return self.localDatamanager!.numberOfTweets(inSection: section) }
        return 0
    }
    
    func numberOfSections() -> Int
    {
        if localDatamanager != nil  { return self.localDatamanager!.numberOfSections() }
        return 0
    }
    
    func twitterListItemAtIndexPath(indexPath: NSIndexPath) -> TwitterListItem
    {
        return self.localDatamanager!.twitterListItemAtIndexPath(indexPath)
    }
    
    //MARK: - TwitterListLocalDataManagerOutputProtocol
    
    func tweetSectionsDidChange(changeType: TwitterListChangeType, atIndex Index: Int)
    {
        self.presenter?.tweetSectionsDidChange(changeType, atIndex: Index)
    }
    
    func tweetDidChange(changeType: TwitterListChangeType, tweet: TwitterListItem, atIndexPath indexPath: NSIndexPath?, newIndexPath: NSIndexPath?)
    {
        self.presenter?.tweetDidChange(changeType, tweet: tweet, atIndexPath: indexPath, newIndexPath: newIndexPath)
    }
    
    func tweetsListWillChange()
    {
        self.presenter?.tweetsListWillChange()
    }
    
    func tweetsListDidChange()
    {
        self.presenter?.tweetsListDidChange()
    }
}