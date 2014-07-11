//
//  SMGUtilities.m
//
//
//  Created by Marcus Lewis on 2/8/14.
//  Copyright (c) 2014 Marcus Lewis. All rights reserved.
//

#import "SMGUtilities.h"
#import "SMGAppDelegate.h"

// Since the status bar and tab bar heights can change for each device, we'll make this a query function

#define STATUSBARHEIGHT 20.0f   // status bar is 20.0 points high
//#define TABBARHEIGHT 49.0f      // tab bar is usually 49.0 points high but not always!

//#define STATUSBARHEIGHT  [self getStatusBarHeight]
#define TABBARHEIGHT     [self getTabBarHeight]

@implementation SMGUtilities

+ (BOOL) iOS7check {
    return (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1);
}

+ (CGRect) getScreenFrame {
    return CGRectMake(0.0,0.0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height);
}

+ (CGRect) getScreenFrameMinusStatusAndTabBars {
    //
    // In iOS7 the scrollView class has a new "feature": it disappears beneath both the tab bar and status
    // bar by default. This method will return a frame that is between the status bar
    // and tab bar.
    //
    
    BOOL iOS7 = [self iOS7check];
    
    if (!iOS7) {
        return CGRectMake(0.0,0.0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height - STATUSBARHEIGHT);
    }
    else {
        return CGRectMake(0.0, STATUSBARHEIGHT, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - (STATUSBARHEIGHT+TABBARHEIGHT));
    }
}

+ (CGRect) getScreenFrameMinusTabBar {
    //
    // In iOS7 the scrollview disappears beneath both the tab bar and status
    // bar by default. This will return a frame that is above the tab bar.
    //
    
    BOOL iOS7 = [self iOS7check];
    
    if (!iOS7) {
        return CGRectMake(0.0,0.0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height - STATUSBARHEIGHT);
    }
    else {
        return CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - (STATUSBARHEIGHT+TABBARHEIGHT));
    }
}

+ (CGRect) getScreenFrameMinusStatusBar {
    //
    // In iOS7 the scrollview disappears beneath both the tab bar and status
    // bar by default. This will return a frame that is below the status bar.
    //
    
    
    BOOL iOS7 = [self iOS7check];
    
    if (!iOS7) {
        return CGRectMake(0.0,0.0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height - STATUSBARHEIGHT);
    }
    else {
        return CGRectMake(0.0, STATUSBARHEIGHT, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - STATUSBARHEIGHT);
    }
}

+ (float) getStatusBarHeight {
    //
    // Status bar height 20 pts will auto-adjust to 40 pts on retina displays.
    //
    
    return 20.0f;
}

+ (float) getTabBarHeight {
    //
    // But the Tab bar height varies per device so we ask for it directly.
    //
    SMGAppDelegate *delegate = (SMGAppDelegate*) [[UIApplication sharedApplication] delegate];
    return delegate.tabBarController.tabBar.frame.size.height;
    
}



@end
