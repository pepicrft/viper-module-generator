//
// Created by Pedro Piñera Buendía on 2014.
// Copyright (c) 2014 Redbooth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIPERProtocols.h"

@interface VIPERViewController : UIViewController <VIPERViewProtocol>

@property (nonatomic, strong) id <VIPERPresenterProtocol> presenter;

@end
