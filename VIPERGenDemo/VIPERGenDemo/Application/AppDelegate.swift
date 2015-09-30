//
//  AppDelegate.swift
//  VIPERGenDemo
//
//  Created by AUTHOR on 22/08/14.
//  Copyright (c) 2014 ___PPinera___. All rights reserved.
//


import UIKit
import SwifteriOS

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        setupStorage()
        self.launchRootViewDependingOnLoggedStatus()
        window!.makeKeyAndVisible()
        return true
    }
    
    func application(application: UIApplication!, openURL url: NSURL!, sourceApplication: String!, annotation: AnyObject!) -> Bool {
        TwitterClient.handleOpenURL(url)
        return true
    }
    
    // MARK - Helpers
    
    /**
    Check the account status and presents (Login | Home)
    */
    func launchRootViewDependingOnLoggedStatus()
    {
        if TwitterAccountManager.isUserLogged() {
            let twitterClientSetup: Bool = self.setupTwitterClient()
            if (!twitterClientSetup) {
                TwitterLoginWireFrame.presentTwitterLoginModule(inWindow: window!)
            }
            else {
                TwitterListWireFrame.presentTwitterListModule(inWindow: window!)
            }
        }
        else {
            TwitterLoginWireFrame.presentTwitterLoginModule(inWindow: window!)
        }
    }
    
    /**
    Restores the user account in case of having the credentials locally
    
    :returns: Bool indicating if the TwitterClient credentials has been properly restored
    */
    func setupTwitterClient() -> Bool
    {
        let key: String? = TwitterAccountManager.attribute(TwitterAccountAttribute.TwitterAccountAttributeKey) as? String
        let secret: String? = TwitterAccountManager.attribute(TwitterAccountAttribute.TwitterAccountAttributeSecret) as? String
        if (key == nil || secret == nil) { return false }
        else {
            TwitterClient.sharedInstance.client.credential = SwifterCredential(accessToken: SwifterCredential.OAuthAccessToken(key: key!, secret: secret!))
            return true
        }
    }
    
    func applicationWillResignActive(application: UIApplication!) {
        SugarRecord.applicationWillResignActive()
    }
    
    func applicationWillEnterForeground(application: UIApplication!) {
        SugarRecord.applicationWillEnterForeground()
    }
    
    func applicationWillTerminate(application: UIApplication!) {
        SugarRecord.applicationWillTerminate()
    }
}
