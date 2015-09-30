//
//  LocalServices.swift
//  VIPERGenDemo
//
//  Created by AUTHOR on 12/11/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation

//MARK: User

let logoutFunction: () -> () = {
    TwitterAccountManager.clean()
    TwitterClient.reset()
}


//MARK: Storage

let setupStorage: () -> () = {
    let stack: DefaultCDStack = DefaultCDStack(databaseName: "VIPER.sqlite", automigrating: true)
    SugarRecord.addStack(stack)
}
