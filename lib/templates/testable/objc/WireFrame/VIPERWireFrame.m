//
// Created by AUTHOR.
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

#import "VIPERWireFrame.h"

@implementation VIPERWireFrame

+ (void)presentVIPERModuleFrom:(UIViewController*)fromViewController
{
    // Generating module components
    UIViewController <VIPERViewProtocol> *viewController = [[VIPERViewController alloc] init];
    id <VIPERPresenterProtocol, VIPERInteractorOutputProtocol> presenter = [VIPERPresenter new];
    id <VIPERInteractorInputProtocol, VIPERDataManagerOutputProtocol> interactor = [VIPERInteractor new];
    id <VIPERDataManagerInputProtocol> dataManager = [VIPERDataManager new];
    VIPERWireFrame *wireFrame = [VIPERWireFrame new];
    
    // Connecting
    viewController.presenter = presenter;
    presenter.view = viewController;
    presenter.wireFrame = wireFrame;
    presenter.interactor = interactor;
    interactor.presenter = presenter;
    interactor.dataManager = dataManager;
    dataManager.interactor = interactor;

    //TOODO - New view controller presentation (present, push, pop, .. )
}

@end
