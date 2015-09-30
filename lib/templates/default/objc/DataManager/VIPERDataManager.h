//
// Created by Pedro Piñera Buendía on 2014.
// Copyright (c) 2014 Redbooth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIPERProtocols.h"


@interface VIPERDataManager : NSObject <VIPERDataManagerInputProtocol>

// Properties
@property (nonatomic, weak) id <VIPERDataManagerOutputProtocol> interactor;

@end