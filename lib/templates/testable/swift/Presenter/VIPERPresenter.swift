//
// Created by AUTHOR.
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation

class VIPERPresenter: VIPERPresenterProtocol, VIPERInteractorOutputProtocol
{
    weak var view: VIPERViewProtocol?
    var interactor: VIPERInteractorInputProtocol?
    var wireFrame: VIPERWireFrameProtocol?
    
    init() {}
}