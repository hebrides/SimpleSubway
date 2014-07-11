//
//  SMGUtilities.h
//  SimpleSubway
//
//  Created by Marcus Lewis on 2/8/14.
//  Copyright (c) 2014 Marcus Lewis. All rights reserved.
//
//  My general utilities class. As I learn more Objective C,
//  I plan to add more capabilities :-)
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface SMGUtilities : NSObject

+ (BOOL) iOS7check;
+ (CGRect) getScreenFrame;
+ (CGRect) getScreenFrameMinusStatusAndTabBars;
+ (CGRect) getScreenFrameMinusStatusBar;
+ (CGRect) getScreenFrameMinusTabBar;


@end
