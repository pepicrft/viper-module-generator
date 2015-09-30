//
//  TwitterLoginProtocols.swift
//  TwitterLoginGenDemo
//
//  Created by AUTHOR on 22/08/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation

protocol TwitterLoginViewProtocol: class
{
    var presenter: TwitterLoginPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func setLoginTitle(let title: String)
    func setLogo(let image: UIImage)
    func showError(let errorMessage: String)
    func showLoading()
    func hideLoading()
}

protocol TwitterLoginWireFrameProtocol: class
{
    class func presentTwitterLoginModule(inWindow window: UIWindow)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func presentHome(fromView view: AnyObject, completion: ((completed: Bool) -> ())?)
}

protocol TwitterLoginPresenterProtocol: class
{
    var view: TwitterLoginViewProtocol? { get set }
    var interactor: TwitterLoginInteractorInputProtocol? { get set }
    var wireFrame: TwitterLoginWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func viewDidLoad()
    func userDidSelectLogin()
}

protocol TwitterLoginInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol TwitterLoginInteractorInputProtocol: class
{
    var presenter: TwitterLoginInteractorOutputProtocol? { get set }
    var APIDataManager: TwitterLoginAPIDataManagerInputProtocol? { get set }
    var localDatamanager: TwitterLoginLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */

    func login(completion: (error: NSError?) -> ())
}

protocol TwitterLoginDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
}

protocol TwitterLoginAPIDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
    func login(completion: (error: NSError?, loginItem: TwitterLoginItem?) -> ())
}

protocol TwitterLoginLocalDataManagerInputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
    func persistUserCredentials(#credentials: TwitterLoginItem)
    func setupLocalStorage()
}
