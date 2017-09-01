//
//  SMGUtilities.h
//  SimpleSubway
//
//  Created by Bolt Action on 2/8/14.
//  Copyright (c) 2017 Bolt Action. All rights reserved.
//


//
// Brand Colors
// ------------


// #ffdd00 (255,221,0) (Yellow)
#define BRAND_COLOR_YELLOW [UIColor colorWithRed:255/255.0f green:221/255.0f blue:0/255.0f alpha:1.0f]
// #ffb400 (255,180,0) (Orange)
#define BRAND_COLOR_ORANGE [UIColor colorWithRed:255/255.0f green:180/255.0f blue:0/255.0f alpha:1.0f]
// #1349a3 (19,73,163) (Blue, for Menus)
#define BRAND_COLOR_BLUE [UIColor colorWithRed:19/255.0f green:73/255.0f blue:163/255.0f alpha:1.0f]


#define GRAY_VERY_LIGHT [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1.0f]
#define GRAY_LIGHT [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0f]
#define GRAY_95 [UIColor colorWithRed:95/255.0f green:95/255.0f blue:95/255.0f alpha:1.0f]
#define GRAY_83 [UIColor colorWithRed:83/255.0f green:83/255.0f blue:83/255.0f alpha:1.0f]
#define GRAY_DARK [UIColor colorWithRed:50/255.0f green:50/255.0f blue:50/255.0f alpha:1.0f]
#define GRAY_VERY_DARK [UIColor colorWithRed:31/255.0f green:31/255.0f blue:31/255.0f alpha:1.0f]

#define WHITE [UIColor whiteColor]

#define TAB_BAR_COLOR GRAY_DARK
#define TAB_ICON_COLOR WHITE
#define TAB_ICON_COLOR_SELECTED BRAND_COLOR_ORANGE

#define STATUS_BAR_COLOR GRAY_DARK

#define VIEW_BACKGROUND_COLOR WHITE

//[UIColor clearColor]



//
// Screen & User Interface Standard Sizes Shorthand
// ------------------------------------------------

#define STATUS_BAR_HEIGHT 20.0f
#define TABBARHEIGHT 49.0f //35.0f
#define SCREENFRAME [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH SCREENFRAME.size.width
#define SCREEN_HEIGHT SCREENFRAME.size.height

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface SMGUtilities : NSObject

+ imageWithName:(NSString *)imageName Size:(CGSize)size;

@end


// Extend UIImage - image overlay effect
@interface UIImage(Overlay)
- (UIImage *)imageWithColor:(UIColor *)color1;
@end


