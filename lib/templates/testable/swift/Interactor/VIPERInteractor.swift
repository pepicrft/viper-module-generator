//
// Created by AUTHOR.
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

import Foundation

final class VIPERInteractor: VIPERInteractorInputProtocol
{
    weak var presenter: VIPERInteractorOutputProtocol?
    var APIDataManager: VIPERAPIDataManagerInputProtocol?
    var localDataManager: VIPERLocalDataManagerInputProtocol?
    
    init() {}
}