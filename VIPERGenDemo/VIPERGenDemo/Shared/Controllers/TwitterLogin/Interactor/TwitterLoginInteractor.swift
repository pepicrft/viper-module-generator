//
//  TwitterLoginInteractor.swift
//  TwitterLoginGenDemo
//
//  Created by AUTHOR on 24/10/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation

class TwitterLoginInteractor: TwitterLoginInteractorInputProtocol
{
    weak var presenter: TwitterLoginInteractorOutputProtocol?
    var APIDataManager: TwitterLoginAPIDataManagerInputProtocol?
    var localDatamanager: TwitterLoginLocalDataManagerInputProtocol?
    
    init() {}
    
    
    // MARK: - TwitterLoginInteractorInputProtocol
    
    func login(completion: (error: NSError?) -> ())
    {
        self.APIDataManager?.login({ [weak self] (error: NSError?, credentials: TwitterLoginItem?) -> () in
            if (credentials != nil) {
                self?.localDatamanager?.persistUserCredentials(credentials: credentials!)
                self?.localDatamanager?.setupLocalStorage()
                completion(error: nil)
            }
            else {
                completion(error: error)
            }
        })
    }
}