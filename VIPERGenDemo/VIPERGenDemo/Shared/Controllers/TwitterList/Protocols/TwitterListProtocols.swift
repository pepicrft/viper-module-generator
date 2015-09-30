//
//  TwitterListProtocols.swift
//  TwitterListGenDemo
//
//  Created by AUTHOR on 22/08/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation
import CoreData

protocol TwitterListViewProtocol: class
{
    var presenter: TwitterListPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func setViewTitle(title: String)
    func stopRefreshing()
    func showError(errorMessage: String)
    func contentWillChange()
    func contentDidChange()
    func insertTweet(atIndexPath: NSIndexPath)
    func insertSection(atIndex: Int)
}

protocol TwitterListWireFrameProtocol: class
{
    class func presentTwitterListModule(inWindow window: UIWindow)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func openLogin(fromView view: AnyObject)
}

protocol TwitterListPresenterProtocol: class
{
    var view: TwitterListViewProtocol? { get set }
    var interactor: TwitterListInteractorInputProtocol? { get set }
    var wireFrame: TwitterListWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func viewDidLoad()
    func numberOfTweets(inSection section: Int) -> Int
    func numberOfSections() -> Int
    func userDidSelectTweet(atIndexPath indexPath: NSIndexPath)
    func setTweetContent(usingPresenter presenter: AnyObject)
    func logout()
    func refreshTweets()
    func userDidScrollToBottom()
    func setContentToView(view: TwitterListItemViewProtocol, indexPath: NSIndexPath)
}

protocol TwitterListInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func tweetSectionsDidChange(changeType: TwitterListChangeType, atIndex Index: Int)
    func tweetDidChange(changeType: TwitterListChangeType, tweet: TwitterListItem, atIndexPath indexPath: NSIndexPath?, newIndexPath: NSIndexPath?)
    func tweetsListWillChange()
    func tweetsListDidChange()
}

protocol TwitterListInteractorInputProtocol: class
{
    var presenter: TwitterListInteractorOutputProtocol? { get set }
    var APIDataManager: TwitterListAPIDataManagerInputProtocol? { get set }
    var localDatamanager: TwitterListLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func logoutUser(completion: (error: NSError?) -> ())
    func refreshTweets(completion: (error: NSError?) -> ())
    func downloadOlderTweets(completion: (error: NSError?) -> ())
    func loadLocalTweets()
    func numberOfTweets(inSection section: Int) -> Int
    func numberOfSections() -> Int
    func twitterListItemAtIndexPath(indexPath: NSIndexPath) -> TwitterListItem
}

protocol TwitterListDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol TwitterListAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
    func downloadTweets(#fromID: Double, amount: Int, completion: (error: NSError?, tweets: [TwitterListItem]?) -> ())
    func downloadTweets(#before: NSDate, amount: Int, completion: (error: NSError?, tweets: [TwitterListItem]?) -> ())
    func downloadTweets(amount: Int, completion: (error: NSError?, tweets: [TwitterListItem]?) -> ())
}

protocol TwitterListLocalDataManagerInputProtocol: class
{
    var interactor: TwitterListLocalDataManagerOutputProtocol? { get set }
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
    func logoutUser()
    func loadLocalTweets()
    func mostRecentTweetIdentifier() -> Double?
    func oldestTweetDate() -> NSDate?
    func persist(#tweets: [TwitterListItem])
    func numberOfTweets(inSection section: Int) -> Int
    func numberOfSections() -> Int
    func twitterListItemAtIndexPath(indexPath: NSIndexPath) -> TwitterListItem
}

protocol TwitterListLocalDataManagerOutputProtocol: class
{
    /**
    * Add here your methods for communication LOCALDATAMANAGER -> INTERACTOR
    */

    func tweetSectionsDidChange(changeType: TwitterListChangeType, atIndex Index: Int)
    func tweetDidChange(changeType: TwitterListChangeType, tweet: TwitterListItem, atIndexPath indexPath: NSIndexPath?, newIndexPath: NSIndexPath?)
    func tweetsListWillChange()
    func tweetsListDidChange()
}

protocol TwitterListItemViewProtocol: class
{
    func set(#date: String)
    func set(#body: String)
    func set(#avatar: String)
    func set(#username: String)
}

//MARK: - Helpers

enum TwitterListChangeType {
    case Insert, Delete, Move, Update
    static func from(fetchedResultsControllerChangeType: NSFetchedResultsChangeType) -> TwitterListChangeType
    {
        switch(fetchedResultsControllerChangeType) {
        case NSFetchedResultsChangeType.Insert:
            return TwitterListChangeType.Insert
        case NSFetchedResultsChangeType.Move:
            return TwitterListChangeType.Move
        case NSFetchedResultsChangeType.Delete:
            return TwitterListChangeType.Delete
        default:
            return TwitterListChangeType.Update
        }
    }
}

