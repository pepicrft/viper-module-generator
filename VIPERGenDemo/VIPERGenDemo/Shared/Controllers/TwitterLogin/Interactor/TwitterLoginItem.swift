//
//  TwitterAccount.swift
//  VIPERGenDemo
//
//  Created by AUTHOR on 11/11/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation
import SwifteriOS

public struct TwitterLoginItem {
    
    public var key: String
    public var secret: String
    public var verifier: String?
    public var screenName: String?
    public var userID: String?
    
    public init(swifterCredentials: SwifterCredential.OAuthAccessToken)
    {
        self.key = swifterCredentials.key
        self.secret = swifterCredentials.secret
        self.verifier = swifterCredentials.verifier
        self.screenName = swifterCredentials.screenName
        self.userID = swifterCredentials.userID
    }
}