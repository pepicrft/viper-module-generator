//
//  AccountManager.swift
//  VIPERGenDemo
//
//  Created by AUTHOR on 10/11/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation


class TwitterAccountManager: TwitterAccountManagerProtocol
{
    //MARK: - AccountManagerProtocol
    
    /**
    Returns if the user has already logged
    
    :returns: Bool indicating if the user is logged
    */
    class func isUserLogged() -> Bool
    {
        return userDictionary().count != 0
    }
 
    /**
    Persist an account attribute into the local account persistance
    
    :param: accountAttribute Account attribute to be persisted
    :param: value            Value of the persisted attribute
    */
    class func set(#accountAttribute: TwitterAccountAttribute, value: AnyObject)
    {
        var dict: [String: AnyObject] = userDictionary()
        dict[accountAttribute.rawValue] = value
        persistUserDictionary(dict)
    }
    
    class func attribute(attribute: TwitterAccountAttribute) -> AnyObject?
    {
        var dict: [String: AnyObject] = userDictionary()
        let value: AnyObject? = dict[attribute.rawValue]
        return value
    }
    
    /**
    Removes the persisted account
    */
    class func clean()
    {
        persistUserDictionary(nil)
    }
    
    //MARK: - Private
    
    private struct Constants
    {
        private static let NSUSERDEFAULTS_KEY = "UserDefaultsAccountKey"
    }
    
    private class func userDictionary() -> [String: AnyObject]
    {
        var userDictionary: [String: AnyObject]? = NSUserDefaults.standardUserDefaults().objectForKey(Constants.NSUSERDEFAULTS_KEY) as [String: AnyObject]?
        if userDictionary != nil { return userDictionary! }
        return [String: AnyObject]()
    }
    
    private class func persistUserDictionary(userAccount: [String: AnyObject]?)
    {
        NSUserDefaults.standardUserDefaults().setObject(userAccount, forKey: Constants.NSUSERDEFAULTS_KEY)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}


/**
*  AccountManager + TwitterLoginItem Extension
*/
extension TwitterAccountManager
{
    class func persistAccount(fromLoginItem loginItem: TwitterLoginItem)
    {
        var dict: [String: AnyObject] = userDictionary()
        dict[TwitterAccountAttribute.TwitterAccountAttributeKey.rawValue] = loginItem.key
        dict[TwitterAccountAttribute.TwitterAccountAttributeSecret.rawValue] = loginItem.secret
        dict[TwitterAccountAttribute.TwitterAccountAttributeVerifier.rawValue] = loginItem.verifier
        dict[TwitterAccountAttribute.TwitterAccountAttributeScreenName.rawValue] = loginItem.screenName
        dict[TwitterAccountAttribute.TwitterAccountAttributeUserID.rawValue] = loginItem.userID
        persistUserDictionary(dict)
    }
}