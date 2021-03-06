//
//  SMGTabSubMenu
//  simplesubway
//
//  Created by Marcus Skye Lewis on 2/11/17.
//  Copyright © 2017 Skye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMGTabSubMenu; // declare protocol before @interface

@protocol SMGTabSubMenuDelegate <NSObject>
- (void)tabSubMenu:(SMGTabSubMenu *)subMenu didSelectSubMenuItem:(NSInteger)subMenuItemIndex;
@end

@interface SMGTabSubMenu : UIView

@property (nonatomic, weak)  id <SMGTabSubMenuDelegate>        delegate;
@property (nonatomic, strong)           NSArray*               subMenuViews;
@property (nonatomic, strong)           NSString*              title;
@property (nonatomic)                   NSInteger              tabNumber;
@property (nonatomic)                   BOOL                   menuOpen;
@property (nonatomic)                   BOOL                   animating;
@property (nonatomic)                   float                  tabBarHeight;

- (id)initWithSubMenuViews:(NSArray*)itemNames title:(NSString*)title tabNumber:(NSInteger)tabNumber tabBarHeight:(float)tabBarHeight;

- (void)animateMenu;



@end


