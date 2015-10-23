//
// Created by AUTHOR.
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation
import UIKit
final class VIPERWireFrame: VIPERWireFrameProtocol
{
    class func setupVIPERModule(object: AnyObject) -> UIViewController
    {
        // Generating module components
        let view: VIPERViewProtocol = VIPERView()
        let presenter: protocol<VIPERPresenterProtocol, VIPERInteractorOutputProtocol> = VIPERPresenter()
        let interactor: VIPERInteractorInputProtocol = VIPERInteractor()
        let APIDataManager: VIPERAPIDataManagerInputProtocol = VIPERAPIDataManager()
        let localDataManager: VIPERLocalDataManagerInputProtocol = VIPERLocalDataManager()
        let wireFrame: VIPERWireFrameProtocol = VIPERWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDataManager = localDataManager
        
        return UINavigationController(rootViewController: view as! UIViewController)
    }
}