//
//  SMGAppDelegate.h
//  NYC Subway Map
//
//  Created by Marcus Lewis on 12/17/13.
//  Copyright (c) 2013 Marcus Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>


@interface SMGAppDelegate : UIResponder <UIApplicationDelegate>

//
// Properties here can be accessed by importing SMGAppDelegate.h
// and creating a pointer to the shared delegate 
// -------------------------------------------------------------

@property (strong, nonatomic)          UIWindow *window;
@property (nonatomic, strong)          UITabBarController* tabBarController;

- (void)animateSubMenuVisible:(BOOL)visible animated:(BOOL)animated;
- (void) subMenuButtonTouched:(UIButton*)button;

@end
