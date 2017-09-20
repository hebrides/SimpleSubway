//
//  SMGTabSubMenu.m
//  simplesubway
//
//  Created by Marcus Skye Lewis on 2/11/17.
//  Copyright © 2017 Bolt Action. All rights reserved.
//

#import "SMGTabSubMenu.h"
#import "SMGUtilities.h"
#import "SMGButton.h"
#import "SMGTabBarController.h"
#import "SMGTabBar.h"
#import "SMGTabBarItem.h"
#import "SMGScrollView.h"

@interface SMGTabSubMenu () <SMGTabBarControllerDelegate, SMGButtonDelegate>

@end

@implementation SMGTabSubMenu


- (id)initWithSubMenuViews:(NSArray*)subMenuViews title:(NSString*)title tabNumber:(NSInteger)tabNumber {

  if (self = [super init]) {
    _subMenuViews = subMenuViews;
    _title = title;
    _tabNumber = tabNumber;
    _menuOpen = NO;
    _animating = NO;
    [self setUpSubMenu];
  } else {

#ifdef DEBUG
    NSLog(@"SubMenu Init Fail");
#endif

  }

  return self;
  
}


- (void) setUpSubMenu {
  
  if (!_subMenuViews){
    return;
  }
 
  // Create the container for the menu
  NSInteger numberOfMenuItems = [_subMenuViews count];
  float menuItemHeight = TABBARHEIGHT;
  float menuItemWidth = SCREEN_WIDTH;
  float menuHeight = numberOfMenuItems * menuItemHeight;
  float menuWidth = SCREEN_WIDTH;
  
  // Place menu at bottom of screen -- for under the tab bar, use: SCREEN_HEIGHT-TABBARHEIGHT, and see next animateMenu
  self.frame = CGRectMake(0,SCREEN_HEIGHT, menuWidth, menuHeight);
  self.backgroundColor =  SUBMENU_BACKGROUND_COLOR;
  
  // Make SubMenu Top Line
  UIView *topline = [[UIView alloc] initWithFrame: CGRectMake(0, -SUBMENU_LINE_SIZE, SCREEN_WIDTH, SUBMENU_LINE_SIZE)];
  topline.backgroundColor = SUBMENU_LINE_COLOR;
  topline.alpha =.5f;
  [self addSubview: topline];

  // Create menu items

  float menuTitleHeight = 0;

  // Create a title bar if asked -- this needs work
  if (_title) {
    menuTitleHeight = menuItemHeight/2;
    self.frame = CGRectMake(0,SCREEN_HEIGHT-TABBARHEIGHT, menuWidth, menuHeight + menuTitleHeight);
    UILabel * menuTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, menuItemWidth, menuTitleHeight)];
    menuTitle.font = [UIFont fontWithName:@"Trebuchet MS" size:14.0];
    menuTitle.text = _title;
    menuTitle.textAlignment = NSTextAlignmentCenter;
    menuTitle.textColor = WHITE;
    [self addSubview:menuTitle];
  }

  for (int i=0; i< numberOfMenuItems; i++) {
    NSString * itemName = [NSString stringWithFormat:@"   %@", [(SMGScrollView *)[_subMenuViews objectAtIndex:i] title]];
    SMGButton* nthButton = [[SMGButton alloc] initWithFrame:CGRectMake(0.0, menuTitleHeight+(menuItemHeight*i), menuItemWidth, menuItemHeight) tag:i title:itemName ];
    
    //
    // Make Item Separator
    // -------------------
    UIView *lineSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, -SUBMENU_DIVIDER_SIZE, SCREENFRAME.size.width, SUBMENU_DIVIDER_SIZE)];
    lineSeparator.alpha =.5f;
    lineSeparator.backgroundColor = SUBMENU_DIVIDER_COLOR;
    [nthButton addSubview:lineSeparator];

    
    
    // Add buttons to menu
    [nthButton addTarget:self
                  action:@selector(subMenuItemSelected:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview: nthButton];
  }
  
  
}

- (void) subMenuItemSelected:(SMGButton*)sender {
  // Close this subMenu
  [self animateMenu];

  if ([[self delegate] respondsToSelector:@selector(tabSubMenu:didSelectSubMenuItem:)]) {
    [[self delegate] tabSubMenu:self didSelectSubMenuItem:sender.tag ];
  }

}

#pragma mark - Animations

- (void)animateMenu {
#ifdef DEBUG
  NSLog(@"### ---> animate menu <--- ###");
  NSLog(@"### menu Y = %f ###",self.frame.origin.y);
#endif
  
  if (_animating) return;

  _animating = YES;
  
  // get current frame, check if menu open, assign open and closed menu offsets // remove TABBARHEIGHT for non-hiding tabBar
  CGFloat menuOffsetY = (self.menuOpen)? self.frame.size.height + TABBARHEIGHT: -self.frame.size.height - TABBARHEIGHT;
  CGFloat newAlpha = (self.menuOpen)? 0.0 : 1.0; //1.0 : 1.0;
  [self setHidden:NO];


  [UIView animateWithDuration:0.25 animations:^{
    self.frame = CGRectOffset(self.frame, 0, menuOffsetY);
    self.alpha =  newAlpha;
  } completion:^(BOOL finished) {
    self.menuOpen = !self.menuOpen;
    _animating = NO;
  }];
  
}


@end
