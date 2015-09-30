//
//  TwitterListView.swift
//  TwitterListGenDemo
//
//  Created by AUTHOR on 24/10/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation
import UIKit

class TwitterListView: TWViewController, TwitterListViewProtocol, UITableViewDataSource, UITableViewDelegate
{
    // MARK: - Styles
    private struct Styles
    {
        static let COLOR_NAVIGATION_BAR: UIColor = Stylesheet.COLOR_BLUE_LIGHT
        static let COLOR_NAVIGATION_ITEMS: UIColor = UIColor.whiteColor()
        static let FONT_LOGOUT_BUTTON: UIFont = UIFont.systemFontOfSize(15)
        static let COLOR_REFRESH_CONTROL_BACKGROUND: UIColor = UIColor.whiteColor()
        static let COLOR_REFRESH_CONTROL: UIColor = UIColor.lightGrayColor()
        static let FONT_REFRESH_CONTROL: UIFont = UIFont.systemFontOfSize(12)
    }
    
    
    // MARK: - Attributes
    
    var presenter: TwitterListPresenterProtocol?
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.registerClass(TweetCell.self, forCellReuseIdentifier: "tweetCell")
        tableView.allowsSelection = false
        return tableView
    }()
    lazy var refreshControl: UIRefreshControl = {
        var control: UIRefreshControl = UIRefreshControl()
        control.tintColor = Styles.COLOR_REFRESH_CONTROL
        control.backgroundColor = Styles.COLOR_REFRESH_CONTROL_BACKGROUND
        control.attributedTitle = NSAttributedString(string: NSLocalizedString("refreshing tweets with #\(TWITTER_SEARCH_TERM)", comment: ""), attributes: [NSFontAttributeName: Styles.FONT_REFRESH_CONTROL, NSForegroundColorAttributeName: Styles.COLOR_REFRESH_CONTROL])
        return control
    }()
    
    
    // MARK - View Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupSubviews()
        self.setupNavigationBar()
        self.setupAutolayouts()
        self.setupObservers()
        self.navigationController?.setNeedsStatusBarAppearanceUpdate()
        self.presenter?.viewDidLoad()
    }
    
    
    // MARK: Observers
    
    func setupObservers()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredContentSizeChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    func preferredContentSizeChanged(notification: NSNotification)
    {
        self.tableView.reloadData()
    }
    
    
    // MARK: - Subviews
    
    private func setupSubviews()
    {
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.addSubview(self.refreshControl)
        self.refreshControl.addTarget(self, action: Selector("userDidSelectRefresh:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    private func setupNavigationBar()
    {
        // Color
        self.navigationController?.navigationBar.barTintColor = Styles.COLOR_NAVIGATION_BAR
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Styles.COLOR_NAVIGATION_ITEMS]
        
        // Logout Button
        let logoutButton: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("logout", comment: "").firstLetterCapitalized(), style: UIBarButtonItemStyle.Done, target: self, action: Selector("userDidSelectLogout:"))
        logoutButton.setTitleTextAttributes([NSFontAttributeName: Styles.FONT_LOGOUT_BUTTON], forState: UIControlState.Normal)
        logoutButton.tintColor = Styles.COLOR_NAVIGATION_ITEMS
        self.navigationItem.leftBarButtonItem = logoutButton
    }
    
    private func setupAutolayouts()
    {
        self.tableView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
    }
    
    
    // MARK: - User Actions
    
    func userDidSelectLogout(sender: AnyObject)
    {
        self.presenter?.logout()
    }
    
    func userDidSelectRefresh(sender: AnyObject)
    {
        self.presenter?.refreshTweets()
    }
    
    
    // MARK: - TwitterListViewProtocol
    
    func setViewTitle(title: String)
    {
        self.title = title
    }
    
    func stopRefreshing()
    {
        self.refreshControl.endRefreshing()
    }
    
    func showError(errorMessage: String)
    {
        ProgressHUD.showError(errorMessage)
    }
    
    func contentWillChange()
    {
        self.tableView.beginUpdates()
    }
    
    func contentDidChange()
    {
        self.tableView.endUpdates()
    }
    
    func insertTweet(atIndexPath: NSIndexPath)
    {
        self.tableView.insertRowsAtIndexPaths([atIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func insertSection(atIndex: Int)
    {
        self.tableView.insertSections(NSIndexSet(index: atIndex), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    // MARK: - Status Bar
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.presenter!.numberOfTweets(inSection: section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var tweetCell: TweetCell = self.tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as TweetCell
        tweetCell.updateConstraintsIfNeeded()
        self.presenter?.setContentToView(tweetCell, indexPath: indexPath)
        tweetCell.setNeedsUpdateConstraints()
        return tweetCell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return self.presenter!.numberOfSections()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.presenter!.userDidSelectTweet(atIndexPath: indexPath)
    }
    
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - 2*scrollView.frame.size.height {
            self.presenter?.userDidScrollToBottom()
        }
    }
}