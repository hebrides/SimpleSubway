//
//  SMGAppDelegate.m
//  NYC Subway Map
//
//  Created by Marcus Lewis on 12/17/13.
//  Copyright (c) 2017 Marcus Lewis. All rights reserved.
//

#import "SMGAppDelegate.h"
#import "SMGScrollView.h"
#import "SMGUtilities.h"
#import "SMGViewController.h"
#import "Icons.h"

// #import "SMGMapAnnotation.h"

@interface SMGAppDelegate () <UIScrollViewDelegate, SMGTabBarControllerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate, UIWebViewDelegate>

@property (nonatomic)                  CGRect              mainViewFrame;

@property (nonatomic, strong)          SMGViewController*   bikeMapVC;
@property (nonatomic, strong)          SMGViewController*   subwayMapVC;
@property (nonatomic, strong)          SMGViewController*   busMapVC;
@property (nonatomic, strong)          SMGViewController*   mapKitMapVC;
@property (nonatomic, strong)          SMGViewController*   appInfoVC;


@property (nonatomic, strong)          SMGScrollView*      bikeMapView;
@property (nonatomic, strong)          SMGScrollView*      bikeMapNightView;

@property (nonatomic, strong)          SMGScrollView*      subwayMapView;
@property (nonatomic, strong)          SMGScrollView*      subwayMapNightView;

@property (nonatomic, strong)          SMGScrollView*      busBrooklynView;
@property (nonatomic, strong)          SMGScrollView*      busManhattanView;
@property (nonatomic, strong)          SMGScrollView*      busQueensView;
@property (nonatomic, strong)          SMGScrollView*      busBronxView;
@property (nonatomic, strong)          SMGScrollView*      busStatenIslandView;
@property (nonatomic, strong)          SMGScrollView*      currentBusView;

@property (nonatomic, strong)          NSArray*            busMapViews;
@property (nonatomic)                  CGFloat             subMenuHeight;
@property (nonatomic)                  CGFloat             subMenuWidth;

@property (nonatomic, strong)          MKMapView*          mapkitMapView;
@property (nonatomic, strong)          UIWebView*          appInfoView;

@property (nonatomic, strong)          UIView*             statusBarView;
@property (nonatomic)                  BOOL                menuOpen;


@property (nonatomic)                  NSUInteger          bitMask;

@end

@implementation SMGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
#ifdef DEBUG
  NSLog(@"Debug Mode!");
#endif
  
  
  //
  // Set App Styles
  // --------------
  
  // Set color status bar text information -- carrier, time, battery text (white)
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  
  //
  // Initialize SMG Tab Bar Controller
  // ---------------------------------
  [self makeTabBarController];
  
  //
  // Construct Frame for main views that is below status bar, above tab bar
  // ----------------------------------------------------------------------
  
  self.mainViewFrame = CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT - TABBARHEIGHT);
  
  //
  // Initialize ScrollViews for Map Images
  // -------------------------------------
  [self makeScrollViews];
  
  //
  // Initialize View Controllers
  // ---------------------------
  [self makeViewControllers];
  
  //
  // Set Up Tab Bar Iems
  // ---------------------------
  [self setUpTabBarItems];
  
  //
  // Start at Subway Tab
  // ----------------------
  [self.tabBarController setSelectedIndex:2];
  
  //
  // Initialize Main Window
  // ----------------------
  self.window = [[UIWindow alloc] initWithFrame: SCREENFRAME];
  
  //
  // Configure Main Window
  // ---------------------
  [self.window setRootViewController:self.tabBarController];
  [self.window makeKeyAndVisible];
  
  //
  // Create a colored status bar
  // ---------------------------
  [self setStatusBarBackgroundColor];
  
  
  
  return YES;
}

- (void) setStatusBarBackgroundColor {
  
  if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) { // Determine iOS7+
    self.statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_BAR_HEIGHT)];
    self.statusBarView.backgroundColor = STATUS_BAR_COLOR;
    [self.tabBarController.view addSubview: self.statusBarView];
  }
  
}

- (void) makeTabBarController {
  
  self.tabBarController = [[SMGTabBarController alloc] init];
  self.tabBarController.delegate = self; // Handle tab bar here in App Delegate
  [self.tabBarController.tabBar setHeight: TABBARHEIGHT];
  [self.tabBarController.view setBackgroundColor: TAB_BAR_COLOR];
  self.tabBarController.tabBar.backgroundView.backgroundColor = TAB_BAR_COLOR;
  
}


- (void) setUpTabBarItems {
  
  // Add View Controllers to Tab Bar Controller
  NSArray* controllers = [NSArray arrayWithObjects: self.bikeMapVC, self.busMapVC, self.subwayMapVC, self.mapKitMapVC, self.appInfoVC, nil];
  
  
  // Note: Not really clear BUT this makes the tabBarController create correct number of Tab Bar items, so we can then set up the Tab Bar items in the and their SubMenus next step
  
  self.tabBarController.viewControllers = controllers;
  
  
  // SubMenus
  NSArray* bikeMapViews = [NSArray arrayWithObjects: self.bikeMapView, self.bikeMapNightView, nil];
  [self.tabBarController setSubMenuViews:bikeMapViews forTabBarItemAtIndex:0];
  
  NSArray* busMapViews = [NSArray arrayWithObjects: self.busManhattanView, self.busBronxView, self.busBrooklynView, self.busQueensView, self.busStatenIslandView, nil];
  [self.tabBarController setSubMenuViews:busMapViews forTabBarItemAtIndex:1];
  
  // NSArray* subwayMapViews = [NSArray arrayWithObjects:self.subwayMapView, self.subwayMapNightView, nil];
  
  
  
  // Setup Tab Bar items
  NSDictionary* unselectedTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:10.5],
                                             NSForegroundColorAttributeName: [UIColor whiteColor],
                                             };
  NSDictionary* selectedTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:10.5],
                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                           };
  
  NSArray* tabBarImages = [NSArray arrayWithObjects:
                           [Icons imageOfBicycleFilled],
                           [Icons imageOfBusFilled],
                           [Icons imageOfSubFilled],
                           [Icons imageOfMapFilled],
                           [Icons imageOfInfoFilled],
                           nil];
  
  NSInteger count = 0;
  for (SMGTabBarItem *item in self.tabBarController.tabBar.items) {
    
    UIImage *unselectedimage = [[tabBarImages objectAtIndex:count ] imageWithColor:TAB_ICON_COLOR];
    UIImage *selectedimage = [[tabBarImages objectAtIndex:count ] imageWithColor:TAB_ICON_COLOR_SELECTED];
    
    
    [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
    [item setUnselectedTitleAttributes:unselectedTextAttributes];
    [item setSelectedTitleAttributes:selectedTextAttributes];
    [item setTitlePositionAdjustment:UIOffsetMake(0, 3.5)];
    count++;
  }
  
}


- (void) makeScrollViews { // These are the maps
  
  //
  // Subway Map Views
  // ---------------
  self.subwayMapView = [[SMGScrollView alloc] initWithTitle:@"DAY" index:0 frame:self.mainViewFrame  imageName:@"2017Sub" imageSize:CGSizeMake(2560.0, 3072.0)];
  [self.subwayMapView setContentOffset:CGPointMake(0, 0) animated:YES];
  

  
  self.subwayMapNightView = [[SMGScrollView alloc] initWithTitle:@"NIGHT" index:1 frame:self.mainViewFrame imageName:@"2017SubNight" imageSize:CGSizeMake(2560.0, 3072.0)];
  [self.subwayMapNightView setContentOffset:CGPointMake(0, 0) animated:YES];
  
  //
  // Bike Map Views
  // ----------------
  self.bikeMapView = [[SMGScrollView alloc] initWithTitle:@"DAY" index:0 frame:self.mainViewFrame imageName:@"2016Bike2" imageSize:CGSizeMake(4864.0, 7424.0)];
  [self.bikeMapView setContentOffset:CGPointMake(0, 0) animated:YES];
  
  self.bikeMapNightView = [[SMGScrollView alloc] initWithTitle:@"NIGHT" index:1 frame:self.mainViewFrame imageName:@"2016Bike1" imageSize:CGSizeMake(4864.0, 7424.0)];
  [self.bikeMapNightView setContentOffset:CGPointMake(0, 0) animated:YES];
  
  //
  // Bus Maps Views
  // --------------
  self.busManhattanView = [[SMGScrollView alloc] initWithTitle:@"MANHATTAN" index:0 frame:self.mainViewFrame imageName:@"2017BusMan" imageSize:CGSizeMake(2304.0, 7168.0)];
  self.busBrooklynView = [[SMGScrollView alloc] initWithTitle:@"BROOKLYN" index:1 frame:self.mainViewFrame imageName:@"2017BusBk" imageSize:CGSizeMake(5120.0, 5376.0)];
  self.busQueensView = [[SMGScrollView alloc] initWithTitle:@"QUEENS" index:2 frame:self.mainViewFrame imageName:@"2017BusQ" imageSize:CGSizeMake(5120.0, 5632.0)];
  self.busBronxView = [[SMGScrollView alloc] initWithTitle:@"THE BRONX" index:3 frame:self.mainViewFrame imageName:@"2017BusBx" imageSize:CGSizeMake(5120.0, 5376.0)];
  self.busStatenIslandView = [[SMGScrollView alloc] initWithTitle:@"STATEN ISLAND" index: 4 frame:self.mainViewFrame imageName:@"2017BusSI" imageSize:CGSizeMake(5120.0, 5376.0)];
  
  //
  // MapKit Map View
  // ---------------
  self.mapkitMapView = [[MKMapView alloc] initWithFrame:self.mainViewFrame];
  [self.mapkitMapView setDelegate:self];
  CLLocationCoordinate2D startLocation = CLLocationCoordinate2DMake(40.752, -73.979);
  MKCoordinateSpan startAreaSpan = MKCoordinateSpanMake(0.1, 0.1);
  MKCoordinateRegion startArea= MKCoordinateRegionMake(startLocation, startAreaSpan);
  [self.mapkitMapView setRegion:startArea animated:YES];
  CLLocationCoordinate2D  ctrpoint;
  ctrpoint.latitude = 40.752; // The Big Apple!!
  ctrpoint.longitude =-73.979;
  
  // SMGMapAnnotation *fooAnnotation = [[SMGMapAnnotation alloc] initWithCoordinates:ctrpoint placeName:@"Foo" description:@"Bar"];
  // [self.mapkitMapView addAnnotation:fooAnnotation];
  
  // For showing user location (not yet implemented as a button).
  self.mapkitMapView.delegate =  self;
  self.mapkitMapView.showsUserLocation = YES;
  
  //
  // App Info Webview
  // -----------------
  self.appInfoView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 0, self.mainViewFrame.size.width, self.mainViewFrame.size.height)];
  NSURL *url = [[NSBundle mainBundle] URLForResource:@"app_info" withExtension:@"html"];
  [self.appInfoView loadRequest:[NSURLRequest requestWithURL:url]];
  self.appInfoView.delegate = self;

  
}

- (void) makeViewControllers {
  
  UIColor *bgColorForVCs = [UIColor colorWithPatternImage:[SMGUtilities imageWithName:@"bg.png" Size:SCREENFRAME.size]];
  
  // Bike
  self.bikeMapVC = [[SMGViewController alloc] init];
  [self.bikeMapVC.view addSubview: self.bikeMapNightView];
  self.bikeMapView.hidden = false;
  [self.bikeMapVC.view addSubview: self.bikeMapView];
  self.bikeMapVC.view.backgroundColor = bgColorForVCs;
  
  // Subway
  self.subwayMapVC = [[SMGViewController alloc] init];
  self.subwayMapView.hidden = false;
  [self.subwayMapVC.view addSubview: self.subwayMapView];
  self.subwayMapVC.view.backgroundColor = bgColorForVCs;
  
  // Bus
  self.busMapVC = [[SMGViewController alloc] init];
  self.busManhattanView.hidden = false;
  for (UIView* view in [NSArray arrayWithObjects: self.busBronxView, self.busBrooklynView, self.busQueensView, self.busStatenIslandView, self.busManhattanView, nil]) {
    [self.busMapVC.view addSubview: view];    
  }
  self.busMapVC.view.backgroundColor = bgColorForVCs;
  
  // Map
  self.mapKitMapVC = [[SMGViewController alloc] init];
  [self.mapKitMapVC.view addSubview:self.mapkitMapView];
 
  // About
  self.appInfoVC = [[SMGViewController alloc] init];
  [self.appInfoVC.view addSubview:self.appInfoView];
 


}


- (void)applicationWillResignActive:(UIApplication *)application {
  
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (BOOL)webView: (UIWebView*)webView shouldStartLoadWithRequest: (NSURLRequest*)request navigationType: (UIWebViewNavigationType)navigationType {
  
  //
  // Map links starting with "file://" ending with #action with the
  // action of the controller if it exists. Open other links in Safari.
  // ------------------------------------------------------------------
  
#ifdef DEBUG
  NSLog(@"Action from UIWebView!");
#endif
  
  NSString *fragment, *scheme;
  if (navigationType == UIWebViewNavigationTypeLinkClicked) {
    [webView stopLoading];
    fragment = [[request URL] fragment];
    scheme = [[request URL] scheme];
    
    // Call a custom selector!! ;-)
    if ([scheme isEqualToString: @"file"] && [self respondsToSelector: NSSelectorFromString(fragment)]) {
      [self performSelector: NSSelectorFromString(fragment)];
      return NO;
    }
    
    [[UIApplication sharedApplication] openURL: [request URL]];
  }
  return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end


