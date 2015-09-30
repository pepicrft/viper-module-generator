//
//  TwitterLoginLocalDataManager.swift
//  TwitterLoginGenDemo
//
//  Created by AUTHOR on 24/10/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation

class TwitterLoginLocalDataManager: TwitterLoginLocalDataManagerInputProtocol
{
    init() {}
    
    func persistUserCredentials(#credentials: TwitterLoginItem)
    {
        TwitterAccountManager.persistAccount(fromLoginItem: credentials)
    }
    
    func setupLocalStorage()
    {
        SugarRecord.removeDatabase()
        setupStorage()
    }
}