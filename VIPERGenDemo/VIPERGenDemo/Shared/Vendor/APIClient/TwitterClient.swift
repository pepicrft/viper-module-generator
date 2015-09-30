//
//  TwitterClient.swift
//  VIPERGenDemo
//
//  Created by AUTHOR on 09/11/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation
import Accounts
import Social
import SwifteriOS

private var _SingletonASharedInstance = TwitterClient(consumerKey: "U2YlcSsiOD3lxJNcxye1rpxvx", consumerSecret: "hDopZymcZeMh7LDlmEXqyL1R3J5in96iYxEHZIHKlTy0OJd8s6")

class TwitterClient: Swifter
{
    class var sharedInstance : TwitterClient {
        return _SingletonASharedInstance
    }
    class func set(#sharedInstance: TwitterClient)
    {
        _SingletonASharedInstance = sharedInstance
    }
    
    class func reset()
    {
        _SingletonASharedInstance = TwitterClient(consumerKey: "U2YlcSsiOD3lxJNcxye1rpxvx", consumerSecret: "hDopZymcZeMh7LDlmEXqyL1R3J5in96iYxEHZIHKlTy0OJd8s6")
    }
    
    class func requestAccesss(completion: (error: NSError?, credentials: SwifterCredential.OAuthAccessToken?) -> ())
    {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        // Prompt the user for permission to their twitter account stored in the phone's settings
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) {
            granted, error in
            
            if granted {
                let twitterAccounts = accountStore.accountsWithAccountType(accountType)
                
                if twitterAccounts?.count == 0
                {
                    TwitterClient.sharedInstance.authorizeWithCallbackURL(NSURL(string: "vipergen://success")!, success: { (accessToken, response) -> Void in
                        completion(error: nil, credentials: accessToken)
                    }, failure: { (error) -> Void in
                        completion(error: error, credentials: nil)
                    })
                }
                else {
                    let twitterAccount = twitterAccounts[0] as ACAccount
                    TwitterClient.set(sharedInstance: TwitterClient(account: twitterAccount))
                }
            }
            else {
                TwitterClient.sharedInstance.authorizeWithCallbackURL(NSURL(string: "vipergen://success")!, success: { (accessToken, response) -> Void in
                    // TODO: - What do we persist?
                    //completion(error: nil, accessToken: accessToken)
                    }, failure: { (error) -> Void in
                        completion(error: error, credentials: nil)
                })
            }
        }
    }
}