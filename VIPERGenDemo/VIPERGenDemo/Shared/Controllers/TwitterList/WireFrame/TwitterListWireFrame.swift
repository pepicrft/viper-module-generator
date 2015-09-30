//
//  TwitterListWireFrame.swift
//  TwitterListGenDemo
//
//  Created by AUTHOR on 24/10/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation

class TwitterListWireFrame: TwitterListWireFrameProtocol
{
    class func presentTwitterListModule(inWindow window: UIWindow)
    {
        // Generating module components
        var view: TwitterListView = TwitterListView()
        var presenter: protocol<TwitterListPresenterProtocol, TwitterListInteractorOutputProtocol> = TwitterListPresenter()
        var interactor: protocol<TwitterListInteractorInputProtocol, TwitterListLocalDataManagerOutputProtocol> = TwitterListInteractor()
        var APIDataManager: TwitterListAPIDataManagerInputProtocol = TwitterListAPIDataManager()
        var localDataManager: TwitterListLocalDataManagerInputProtocol = TwitterListLocalDataManager()
        var wireFrame: TwitterListWireFrameProtocol = TwitterListWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        localDataManager.interactor = interactor
        
        // Presenting
        let navigationController: TWNavigationController = TWNavigationController(rootViewController: view)
        window.rootViewController = navigationController
    }
    
    // MARK: - TwitterListWireFrameProtocol
    
    func openLogin(fromView view: AnyObject)
    {
        TwitterLoginWireFrame.presentTwitterLoginModule(inWindow: UIApplication.sharedApplication().delegate!.window!!)
    }
}