// SMGTabBarController.m
// SMGTabBarController
//
// Copyright (c) 2017 Bolt Action
//

#import "SMGTabBarController.h"
#import "SMGTabBarItem.h"
#import "SMGScrollView.h"
#import <objc/runtime.h>

@interface UIViewController (SMGTabBarControllerItemInternal)
- (void)smg_setTabBarController:(SMGTabBarController *)tabBarController;

@end


@interface SMGTabBarController () {
  UIView * _contentView;
}

@property (nonatomic, readwrite) SMGTabBar *tabBar;

@end


@implementation SMGTabBarController {
  BOOL _statusBarHidden;
}

#pragma mark - View lifecycle

- (BOOL)prefersStatusBarHidden{
  return _statusBarHidden;
}

-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
  return UIStatusBarAnimationSlide;
}

- (void)showStatusBar:(BOOL)show {
  [UIView animateWithDuration:0.3 animations:^{
    _statusBarHidden = !show;
    [self setNeedsStatusBarAppearanceUpdate];
  }];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.view addSubview:[self contentView]];
  [self.view addSubview:[self tabBar]];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self setSelectedIndex:[self selectedIndex]];
  
  [self setTabBarHidden:self.isTabBarHidden animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return self.selectedViewController.preferredStatusBarStyle;
}


#pragma mark - Methods

- (UIViewController *)selectedViewController {
  return [[self viewControllers] objectAtIndex:[self selectedIndex]];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
#ifdef DEBUG
  NSLog(@"You selected the index: %lu\n", (unsigned long)selectedIndex);
#endif
  
  if (selectedIndex >= self.viewControllers.count) {
    return;
  }
  
  if ([self selectedViewController]) {
    [[self selectedViewController] willMoveToParentViewController:nil];
    [[[self selectedViewController] view] removeFromSuperview];
    [[self selectedViewController] removeFromParentViewController];
  }
  
  _selectedIndex = selectedIndex;
  [[self tabBar] setSelectedItem:[[self tabBar] items][selectedIndex]];
  
  [self setSelectedViewController:[[self viewControllers] objectAtIndex:selectedIndex]];
  [self addChildViewController:[self selectedViewController]];
  [[[self selectedViewController] view] setFrame:[[self contentView] bounds]];
  [[self contentView] addSubview:[[self selectedViewController] view]];
  [[self selectedViewController] didMoveToParentViewController:self];
  
  
  [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setViewControllers:(NSArray *)viewControllers {
  if (_viewControllers && _viewControllers.count) {
    for (UIViewController *viewController in _viewControllers) {
      [viewController willMoveToParentViewController:nil];
      [viewController.view removeFromSuperview];
      [viewController removeFromParentViewController];
    }
  }
  
  if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
    _viewControllers = [viewControllers copy];
    
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
    
    for (UIViewController *viewController in viewControllers) {
      SMGTabBarItem *tabBarItem = [[SMGTabBarItem alloc] init];
      [tabBarItem setTitle:viewController.title];
      [tabBarItems addObject:tabBarItem];
      [viewController smg_setTabBarController:self];
    }
    
    [[self tabBar] setItems:tabBarItems];
  } else {
    for (UIViewController *viewController in _viewControllers) {
      [viewController smg_setTabBarController:nil];
    }
    
    _viewControllers = nil;
  }
}

- (NSInteger)indexForViewController:(UIViewController *)viewController {
  UIViewController *searchedController = viewController;
  if ([searchedController navigationController]) {
    searchedController = [searchedController navigationController];
  }
  return [[self viewControllers] indexOfObject:searchedController];
}

- (SMGTabBar *)tabBar {
  if (!_tabBar) {
    _tabBar = [[SMGTabBar alloc] init];
    [_tabBar setBackgroundColor:[UIColor clearColor]];
    [_tabBar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|
                                  UIViewAutoresizingFlexibleTopMargin|
                                  UIViewAutoresizingFlexibleLeftMargin|
                                  UIViewAutoresizingFlexibleRightMargin|
                                  UIViewAutoresizingFlexibleBottomMargin)];
    [_tabBar setDelegate:self];
  }
  return _tabBar;
}

- (UIView *)contentView {
  if (!_contentView) {
    _contentView = [[UIView alloc] init];
    [_contentView setBackgroundColor:[UIColor whiteColor]];
    [_contentView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|
                                       UIViewAutoresizingFlexibleHeight)];
  }
  return _contentView;
}

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
  _tabBarHidden = hidden;
  
  __weak SMGTabBarController *weakSelf = self;
  
  void (^block)() = ^{
    CGSize viewSize = weakSelf.view.bounds.size;
    CGFloat tabBarStartingY = viewSize.height;
    CGFloat contentViewHeight = viewSize.height;
    CGFloat tabBarHeight = CGRectGetHeight([[weakSelf tabBar] frame]);
    
    if (!tabBarHeight) {
      tabBarHeight = 49;
    }
    
    if (!hidden) {
      tabBarStartingY = viewSize.height - tabBarHeight;
      if (![[weakSelf tabBar] isTranslucent]) {
        contentViewHeight -= ([[weakSelf tabBar] minimumContentHeight] ?: tabBarHeight);
      }
      [[weakSelf tabBar] setHidden:NO];
    }
    
    [[weakSelf tabBar] setFrame:CGRectMake(0, tabBarStartingY, viewSize.width, tabBarHeight)];
    [[weakSelf contentView] setFrame:CGRectMake(0, 0, viewSize.width, contentViewHeight)];
  };
  
  void (^completion)(BOOL) = ^(BOOL finished){
    if (hidden) {
      [[weakSelf tabBar] setHidden:YES];
    }
  };
  
  if (animated) {
    [UIView animateWithDuration:0.24 animations:block completion:completion];
  } else {
    block();
    completion(YES);
  }
}

- (void)setTabBarHidden:(BOOL)hidden {
  [self setTabBarHidden:hidden animated:NO];
}

#pragma mark - SMGTabBarDelegate

- (BOOL)tabBar:(SMGTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index {
  
  [self closeSubMenus];
  
  if ([[self delegate] respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
    if (![[self delegate] tabBarController:self shouldSelectViewController:[self viewControllers][index]]) {
      return NO;
    }
  }
  
  if ([self selectedViewController] == [self viewControllers][index]) {
    if ([[self selectedViewController] isKindOfClass:[UINavigationController class]]) {
      UINavigationController *selectedController = (UINavigationController *)[self selectedViewController];
      
      if ([selectedController topViewController] != [selectedController viewControllers][0]) {
        [selectedController popToRootViewControllerAnimated:YES];
      }
    }
    
    return NO;
  }
  
  return YES;
}

- (void)tabBar:(SMGTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index {
  
  if (index < 0 || index >= [[self viewControllers] count]) {
    return;
  }
  
  [self setSelectedIndex:index];
  
  if ([[self delegate] respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
    [[self delegate] tabBarController:self didSelectViewController:[self viewControllers][index]];
  }
}

- (void)tabSubMenu:(SMGTabSubMenu *)subMenu didSelectSubMenuItem:(NSInteger)subMenuItemIndex {
#ifdef DEBUG
  NSLog(@"SubMenu Index Selected: %li for Tab Item Index: %li", subMenuItemIndex, _selectedIndex);
#endif
  
  if (subMenuItemIndex < 0 || subMenuItemIndex >= [subMenu.subMenuViews count]) {
    return;
  }
  
  for (UIView* view in subMenu.subMenuViews) {
    if (view == [subMenu.subMenuViews objectAtIndex:subMenuItemIndex]) {
      view.hidden = false;
    } else {
      view.hidden = true;
    }
    
  }

 // [_selectedViewController.view bringSubviewToFront:[subMenu.subMenuViews objectAtIndex:subMenuItemIndex]];

  
#ifdef DEBUG
  NSLog(@"Image Name: %@", [[subMenu.subMenuViews objectAtIndex:subMenuItemIndex] imageName]);
#endif
  
  // Note: This forwards the subMenu item select message to the delegate of TabBarController if it's implemented there
  if ([[self delegate] respondsToSelector:@selector(tabBarController:didSelectSubMenu:atItemIndex:)]) {
    [[self delegate] tabBarController:self didSelectSubMenu:subMenu atItemIndex:subMenuItemIndex];
  }
  
}


- (void)tabBar:(SMGTabBar *)tabBar didLongPressItemAtIndex:(NSInteger)index {
#ifdef DEBUG
  NSLog(@"Long press detected at index %li for item %@", index, [self.tabBar.items objectAtIndex:index]);
#endif
  
  // If there's a long press, open the submenu but tabBar:shouldSelectItemAtIndex: has already closed it
  // Else we'd use the below
  
  //  NSInteger itemIndex = 0;
  //  for (SMGTabBarItem* item in self.tabBar.items) {
  //    if (item.subMenu) { // if it has a subMenu
  //      if (itemIndex == index) { // and it's the pressed index, open it
  //        [[item subMenu] animateMenu];
  //      } else if (item.subMenu.menuOpen) { // and close any open subMenus
  //        [[item subMenu] animateMenu];
  //      }
  //    }
  //    itemIndex++;
  //  }
  
  [ [(SMGTabBarItem*) [self.tabBar.items objectAtIndex:index] subMenu]  animateMenu];
  
  // Forward long press message to the delegate of TabBarController
  if ([[self delegate] respondsToSelector:@selector(tabBarController:didLongPressItemAtIndex:)]) {
    [[self delegate] tabBarController:self didLongPressItemAtIndex: index];
  }
}

- (void) closeSubMenus {
  
  for (SMGTabBarItem* item in self.tabBar.items) {
    if (item.subMenu) { // if it has a subMenu
      if (item.subMenu.menuOpen) { // and it's open
        [[item subMenu] animateMenu]; // close it
      }
    }
  }
  
}

- (void)setSubMenuViews:(NSArray*)subMenuViews forTabBarItemAtIndex:(NSInteger)index {

  SMGTabSubMenu * subMenu = [[SMGTabSubMenu alloc] initWithSubMenuViews:subMenuViews title:nil tabNumber:index];
  if (subMenu) {
    [self.view insertSubview:subMenu belowSubview: [self tabBar]];
    [subMenu setDelegate:self];
    // Give Menu Item a reference to its subMenu
    [(SMGTabBarItem*) [self.tabBar.items objectAtIndex:index] setSubMenu:subMenu];
    
    // Let's keep track of what view is where
    if(!_subMenus) {
      _subMenus = [NSMutableArray arrayWithObject:subMenuViews];
    } else {
      [_subMenus addObject:subMenuViews];
    }
  }
  
}


@end



#pragma mark - UIViewController+SMGTabBarControllerItem
@implementation UIViewController (SMGTabBarControllerItemInternal)

- (void)smg_setTabBarController:(SMGTabBarController *)tabBarController {
  objc_setAssociatedObject(self, @selector(smg_tabBarController), tabBarController, OBJC_ASSOCIATION_ASSIGN);
}
@end

@implementation UIViewController (SMGTabBarControllerItem)
- (SMGTabBarController *)smg_tabBarController {
  SMGTabBarController *tabBarController = objc_getAssociatedObject(self, @selector(smg_tabBarController));
  
  if (!tabBarController && self.parentViewController) {
    tabBarController = [self.parentViewController smg_tabBarController];
  }
  
  return tabBarController;
}

- (SMGTabBarItem *)smg_tabBarItem {
  SMGTabBarController *tabBarController = [self smg_tabBarController];
  NSInteger index = [tabBarController indexForViewController:self];
  return [[[tabBarController tabBar] items] objectAtIndex:index];
}

- (void)smg_setTabBarItem:(SMGTabBarItem *)tabBarItem {
  SMGTabBarController *tabBarController = [self smg_tabBarController];
  
  if (!tabBarController) {
    return;
  }
  
  SMGTabBar *tabBar = [tabBarController tabBar];
  NSInteger index = [tabBarController indexForViewController:self];
  
  NSMutableArray *tabBarItems = [[NSMutableArray alloc] initWithArray:[tabBar items]];
  [tabBarItems replaceObjectAtIndex:index withObject:tabBarItem];
  [tabBar setItems:tabBarItems];
}





@end
