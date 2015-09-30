//
// Created by AUTHOR.
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol VIPERDataManagerOutputProtocol;
@protocol VIPERInteractorOutputProtocol;
@protocol VIPERInteractorInputProtocol;
@protocol VIPERViewProtocol;
@protocol VIPERPresenterProtocol;
@protocol VIPERDataManagerInputProtocol;
@class VIPERWireFrame;

typedef void (^CompletionBlock)(NSError **error);

@protocol VIPERViewProtocol
@required
@property (nonatomic, strong) id <VIPERPresenterProtocol> presenter;
/**
 * Add here your methods for communication VIEWCONTROLLER -> PRESENTER
 */
@end

@protocol VIPERPresenterProtocol
@required
@property (nonatomic, weak) id <VIPERViewProtocol> view;
@property (nonatomic, strong) id <VIPERInteractorInputProtocol> interactor;
@property (nonatomic, strong) VIPERWireFrame *wireFrame;
/**
 * Add here your methods for communication VIEWCONTROLLER/WIREFRAME -> PRESENTER
 */
@end

@protocol VIPERInteractorOutputProtocol
/**
 * Add here your methods for communication INTERACTOR -> PRESENTER
 */
@end

@protocol VIPERInteractorInputProtocol
@required
@property (nonatomic, weak) id <VIPERInteractorOutputProtocol> presenter;
/**
 * Add here your methods for communication PRESENTER -> INTERACTOR
 */
@end


@protocol VIPERDataManagerInputProtocol
@property (nonatomic, weak) id <VIPERDataManagerOutputProtocol> interactor;
/**
 * Add here your methods for communication INTERACTOR -> DATAMANAGER
 */
@end

@protocol VIPERDataManagerOutputProtocol
@property (nonatomic, strong) id <VIPERDataManagerInputProtocol> dataManager;
/**
 * Add here your methods for communication DATAMANAGER -> INTERACTOR
 */
@end
