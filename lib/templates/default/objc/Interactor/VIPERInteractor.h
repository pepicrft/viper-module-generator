//
// Created by Pedro Piñera Buendía on 2014.
// Copyright (c) 2014 Redbooth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIPERProtocols.h"


@interface VIPERInteractor : NSObject <VIPERInteractorInputProtocol, VIPERDataManagerOutputProtocol>

// Properties
@property (nonatomic, weak) id <VIPERInteractorOutputProtocol> presenter;
@property (nonatomic, strong) id <VIPERDataManagerInputProtocol> dataManager;

@end