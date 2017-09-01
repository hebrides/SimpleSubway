// SMGTabBar.h
// SMGTabBarController
//
// Copyright (c) 2017 Marcus Lewis


#import <UIKit/UIKit.h>

@class SMGTabBar, SMGTabBarItem;

@protocol SMGTabBarDelegate <NSObject>
- (BOOL)tabBar:(SMGTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index;
- (void)tabBar:(SMGTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index;
- (void)tabBar:(SMGTabBar *)tabBar didLongPressItemAtIndex:(NSInteger)index;
@end


@interface SMGTabBar : UIView

@property (nonatomic, weak)       id <SMGTabBarDelegate>       delegate;
@property (nonatomic, copy)       NSArray                      *items;
@property (nonatomic, copy)       NSArray                      *menus;
@property (nonatomic, weak)       SMGTabBarItem                *selectedItem;
@property (nonatomic, readonly)   UIView                       *backgroundView;
@property                         UIEdgeInsets                 contentEdgeInsets;
@property (nonatomic, getter=isTranslucent) BOOL               translucent;

- (void)setHeight:(CGFloat)height;
- (CGFloat)minimumContentHeight; // Returns the minimum height of tab bar's items.

@end
