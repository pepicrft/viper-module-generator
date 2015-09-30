//
//  TwitterLoginPresenter.swift
//  TwitterLoginGenDemo
//
//  Created by AUTHOR on 24/10/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation

class TwitterLoginPresenter: TwitterLoginPresenterProtocol, TwitterLoginInteractorOutputProtocol
{
    weak var view: TwitterLoginViewProtocol?
    var interactor: TwitterLoginInteractorInputProtocol?
    var wireFrame: TwitterLoginWireFrameProtocol?
    
    init() {}
    
    // MARK: - TwitterLoginPresenterProtocol
    
    func viewDidLoad()
    {
        self.view?.setLoginTitle(NSLocalizedString("Login Twitter", comment: "comment"))
        self.view?.setLogo(UIImage(named: "twitter_logo")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate))
    }
    
    func userDidSelectLogin()
    {
        self.interactor?.login() { [weak self] (error: NSError?) -> () in
            if error != nil {
                self?.view?.showError(error!.localizedDescription)
            }
            else {
                self?.wireFrame?.presentHome(fromView: self!.view!, completion: nil)
            }
        }
    }
}