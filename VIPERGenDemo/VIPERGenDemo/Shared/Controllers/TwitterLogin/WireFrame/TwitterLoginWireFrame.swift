//
//  TwitterLoginWireFrame.swift
//  TwitterLoginGenDemo
//
//  Created by AUTHOR on 24/10/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation

class TwitterLoginWireFrame: TwitterLoginWireFrameProtocol
{
    class func presentTwitterLoginModule(inWindow window: UIWindow)
    {
        // Generating module components
        var view: TwitterLoginViewProtocol = TwitterLoginView()
        var presenter: protocol<TwitterLoginPresenterProtocol, TwitterLoginInteractorOutputProtocol> = TwitterLoginPresenter()
        var interactor: TwitterLoginInteractorInputProtocol = TwitterLoginInteractor()
        var APIDataManager: TwitterLoginAPIDataManagerInputProtocol = TwitterLoginAPIDataManager()
        var localDataManager: TwitterLoginLocalDataManagerInputProtocol = TwitterLoginLocalDataManager()
        var wireFrame: TwitterLoginWireFrameProtocol = TwitterLoginWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        // Presenting
        window.rootViewController = view as? TwitterLoginView
    }
    
    func presentHome(fromView view: AnyObject, completion: ((completed: Bool) -> ())?)
    {
        TwitterListWireFrame.presentTwitterListModule(inWindow: UIApplication.sharedApplication().delegate!.window!!)
    }
}