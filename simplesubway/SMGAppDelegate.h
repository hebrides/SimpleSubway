//
//  SMGAppDelegate.h
//  NYC Subway Map
//
//  Created by Skye on 12/17/13.
//  Copyright (c) 2019 Skye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SMGTabBarController.h"
#import "SMGTabBar.h"
#import "SMGTabBarItem.h"
#import "SMGUtilities.h"


@interface SMGAppDelegate : UIResponder <UIApplicationDelegate>

//
// Properties put here (header file) can be accessed by importing SMGAppDelegate.h
// and creating a pointer to the shared delegate
// -------------------------------------------------------------------------------

@property (nonatomic, strong)           UIWindow*               window;
@property (nonatomic, strong)           SMGTabBarController*    tabBarController;


@end
