// SMGTabBarItem.h
// SMGTabBarController
//
// Copyright (c) 2019 Skye

#import <UIKit/UIKit.h>
#import "SMGTabSubMenu.h"

@interface SMGTabBarItem : UIButton

@property                     CGFloat       itemHeight; //optional property, tabBar's height.
@property (nonatomic, copy)   NSString*     title; // tab bar item title
@property (nonatomic)         UIOffset      titlePositionAdjustment; //offset for the rectangle around the title
@property (copy)              NSDictionary* unselectedTitleAttributes;
@property (copy)              NSDictionary* selectedTitleAttributes;
@property (nonatomic)         UIOffset      imagePositionAdjustment;
@property (nonatomic, copy)   NSString*     badgeValue;
@property (strong)            UIImage*      badgeBackgroundImage;
@property (strong)            UIColor*      badgeBackgroundColor;
@property (strong)            UIColor*      badgeTextColor;
@property (nonatomic)         UIOffset      badgePositionAdjustment;
@property (nonatomic)         UIFont*       badgeTextFont;


@property (nonatomic, strong)         SMGTabSubMenu*       subMenu;

- (UIImage *)finishedSelectedImage;
- (UIImage *)finishedUnselectedImage;
- (void)setFinishedSelectedImage:(UIImage *)selectedImage withFinishedUnselectedImage:(UIImage *)unselectedImage;
- (UIImage *)backgroundSelectedImage;
- (UIImage *)backgroundUnselectedImage;
- (void)setBackgroundSelectedImage:(UIImage *)selectedImage withUnselectedImage:(UIImage *)unselectedImage;
@end
