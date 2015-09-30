//
// Created by AUTHOR.
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIPERProtocols.h"


@interface VIPERInteractor : NSObject <VIPERInteractorInputProtocol, VIPERDataManagerOutputProtocol>

// Properties
@property (nonatomic, weak) id <VIPERInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <VIPERDataManagerInputProtocol> dataManager;

@end