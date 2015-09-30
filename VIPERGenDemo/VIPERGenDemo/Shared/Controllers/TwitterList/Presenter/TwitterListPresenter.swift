//
//  TwitterListPresenter.swift
//  TwitterListGenDemo
//
//  Created by AUTHOR on 24/10/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation

class TwitterListPresenter: TwitterListPresenterProtocol, TwitterListInteractorOutputProtocol
{
    weak var view: TwitterListViewProtocol?
    var interactor: TwitterListInteractorInputProtocol?
    var wireFrame: TwitterListWireFrameProtocol?
    
    init() {}
    
    
    // MARK: - TwitterListPresenterProtocol
    
    func viewDidLoad()
    {
        updateTitle()
        loadLocalTweets()
        self.interactor?.refreshTweets({ (error) -> () in})
    }
    
    func logout()
    {
        self.interactor?.logoutUser() { [weak self] (error: NSError?) -> () in
            if error == nil {
                self!.wireFrame!.openLogin(fromView: self!.view!)
            }
            else {
                self!.view!.showError(NSLocalizedString("couldn't logout", comment: "").firstLetterCapitalized())
            }
        }
    }
    
    func refreshTweets()
    {
        self.interactor?.refreshTweets() { [weak self] (error: NSError?) -> () in
            self!.view!.stopRefreshing()
        }
    }
    
    func loadLocalTweets()
    {
        self.interactor?.loadLocalTweets()
    }
    
    func userDidScrollToBottom()
    {
        self.interactor?.downloadOlderTweets({ [weak self] (error) -> () in
            if error != nil {
                self?.view?.showError(NSLocalizedString("error loading older tweets", comment: "").firstLetterCapitalized())
            }
        })
    }
    
    func setContentToView(view: TwitterListItemViewProtocol, indexPath: NSIndexPath)
    {
        let twitterListItem: TwitterListItem = self.interactor!.twitterListItemAtIndexPath(indexPath)
        view.set(body: twitterListItem.body!)
        view.set(avatar: twitterListItem.avatar!)
        let dateFormater: NSDateFormatter = NSDateFormatter()
        dateFormater.dateStyle = .MediumStyle
        dateFormater.doesRelativeDateFormatting = true
        view.set(date: dateFormater.stringFromDate(twitterListItem.date!))
        view.set(username: twitterListItem.username!)
    }
    
    
    // MARK - Formatting
    
    func updateTitle()
    {
        self.view?.setViewTitle(NSLocalizedString("timeline", comment: "").firstLetterCapitalized())
    }
    
    func numberOfTweets(inSection section: Int) -> Int
    {
        if (self.interactor != nil) { return self.interactor!.numberOfTweets(inSection: section)}
        return 0
    }

    func numberOfSections() -> Int
    {
        if (self.interactor != nil) { return self.interactor!.numberOfSections()}
        return 0
    }
    
    func setTweetContent(usingPresenter presenter: AnyObject)
    {
        //TODO
    }
    
    func userDidSelectTweet(atIndexPath indexPath: NSIndexPath)
    {
        //TODO - Not implemented yet
    }
    
    
    //MARK: - TwitterListInteractorOutputProtocol
    
    func tweetSectionsDidChange(changeType: TwitterListChangeType, atIndex Index: Int)
    {
        if changeType == TwitterListChangeType.Insert
        {
            self.view?.insertSection(Index)
        }
    }
    
    func tweetDidChange(changeType: TwitterListChangeType, tweet: TwitterListItem, atIndexPath indexPath: NSIndexPath?, newIndexPath: NSIndexPath?)
    {
        if changeType == TwitterListChangeType.Insert
        {
            self.view?.insertTweet(newIndexPath!)
        }
    }
    
    func tweetsListWillChange()
    {
        self.view?.contentWillChange()
    }
    
    func tweetsListDidChange()
    {
        self.view?.contentDidChange()
    }
}