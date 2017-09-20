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
#define BRAND_COLOR_ORANGE [UIColor colorWithRed:255/255.0f green:149/255.0f blue:0/255.0f alpha:1.0f]
#define BRAND_COLOR_LIGHT_ORANGE [UIColor colorWithRed:237/255.0f green:215/255.0f blue:107/255.0f alpha:1.0f]
#define BRAND_COLOR_RED [UIColor colorWithRed:237/255.0f green:150/255.0f blue:107/255.0f alpha:1.0f]
// #1349a3 (19,73,163) (Blue, for Menus)
#define BRAND_COLOR_BLUE [UIColor colorWithRed:107/255.0f green:194/255.0f blue:237/255.0f alpha:1.0f]


#define GRAY_VERY_LIGHT [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1.0f]
#define GRAY_LIGHT [UIColor colorWithRed:146/255.0f green:146/255.0f blue:146/255.0f alpha:1.0f]
#define GRAY_95 [UIColor colorWithRed:95/255.0f green:95/255.0f blue:95/255.0f alpha:1.0f]
#define GRAY [UIColor colorWithRed:49/255.0f green:49/255.0f blue:49/255.0f alpha:1.0f]
#define GRAY_DARK [UIColor colorWithRed:24/255.0f green:24/255.0f blue:24/255.0f alpha:1.0f]
#define GRAY_VERY_DARK [UIColor colorWithRed:13/255.0f green:13/255.0f blue:13/255.0f alpha:1.0f]

#define WHITE [UIColor whiteColor]
#define BLACK [UIColor blackColor]


#define VIEW_BACKGROUND_COLOR GRAY_VERY_DARK

#define TAB_BAR_COLOR GRAY_DARK
#define TAB_BAR_LINE_COLOR GRAY
#define TAB_BAR_LINE_SIZE .5f

#define TAB_ICON_COLOR GRAY_LIGHT
#define TAB_ICON_COLOR_SELECTED BRAND_COLOR_BLUE

#define SUBMENU_TOUCH_COLOR BRAND_COLOR_BLUE
#define SUBMENU_BACKGROUND_COLOR GRAY_DARK
#define SUBMENU_DIVIDER_COLOR GRAY
#define SUBMENU_DIVIDER_SIZE 0
#define SUBMENU_LINE_SIZE .5f
#define SUBMENU_LINE_COLOR GRAY
#define SUBMENU_TEXT_COLOR GRAY_VERY_LIGHT

#define STATUS_BAR_COLOR GRAY_DARK
#define STATUS_BAR_LINE_SIZE .5f
#define STATUS_BAR_LINE_COLOR GRAY

//[UIColor clearColor]



//
// Screen & User Interface Standard Sizes Shorthand
// ------------------------------------------------

#define STATUS_BAR_HEIGHT 20.0f
#define TABBARHEIGHT  45.0f // 35.0f
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


