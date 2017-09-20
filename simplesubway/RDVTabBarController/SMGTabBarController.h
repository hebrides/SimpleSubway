// SMGTabBarController.h
// SMGTabBarController
//
// Copyright (c) 2017 Bolt Action
//
// (Based on RDVTabBarController)

#import <UIKit/UIKit.h>
#import "SMGTabBar.h"
#import "SMGTabSubMenu.h"

@protocol SMGTabBarControllerDelegate;

@interface SMGTabBarController : UIViewController <SMGTabBarDelegate, SMGTabSubMenuDelegate>


@property (nonatomic, copy)     NSArray*                          viewControllers;
@property (nonatomic, copy)     NSMutableArray*                   subMenus;
@property (nonatomic, weak)     id <SMGTabBarControllerDelegate>  delegate;
@property (nonatomic, readonly) SMGTabBar*                        tabBar;
@property (nonatomic, weak)     UIViewController*                 selectedViewController;
@property (nonatomic)           NSUInteger                        selectedIndex;
@property (nonatomic)           NSUInteger                        selectedSubIndex;
@property (nonatomic, getter=isTabBarHidden) BOOL                 tabBarHidden;

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)showStatusBar:(BOOL)show;
- (void)setSubMenuViews:(NSArray*)subMenuViews forTabBarItemAtIndex:(NSInteger)index;
- (void) closeSubMenus;

@end



@protocol SMGTabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(SMGTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(SMGTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
- (void)tabController:(SMGTabBarController *)tabBarController didSelectItemAtIndex:(NSInteger)index subMenuIndex:(NSInteger)menuIndex;
- (void)tabBarController:(SMGTabBarController *)tabBarController didLongPressItemAtIndex:(NSInteger) index;
- (void)tabBarController:(SMGTabBarController *)tabBarController didSelectSubMenu:(SMGTabSubMenu *)subMenu atItemIndex:(NSInteger)subMenuItemIndex;
@end


// Extend UIViewController, give it a reference to SMGTabBarItem, and the tab bar controller
@interface UIViewController (SMGTabBarControllerItem)
@property(nonatomic, setter = smg_setTabBarItem:) SMGTabBarItem*        smg_tabBarItem;
@property(nonatomic, readonly)                    SMGTabBarController*  smg_tabBarController;

@end
