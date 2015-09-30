//
// Created by AUTHOR.
// Copyright (c) YEAR AUTHOR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIPERProtocols.h"


@interface VIPERDataManager : NSObject <VIPERDataManagerInputProtocol>

// Properties
@property (nonatomic, weak) id <VIPERDataManagerOutputProtocol> interactor;

@end