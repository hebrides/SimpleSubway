//
//  SMGAppDelegate.m
//  NYC Subway Map
//
//  Created by Skye on 12/17/13.
//  Copyright (c) 2019 Skye. All rights reserved.
//

#import "SMGAppDelegate.h"
#import "SMGScrollView.h"
#import "SMGUtilities.h"
#import "SMGViewController.h"
#import "Icons.h"
#import <sys/utsname.h>

// #import "SMGMapAnnotation.h"

@interface SMGAppDelegate () <SMGScrollViewDelegate, SMGTabBarControllerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate, UIWebViewDelegate> //UIScrollViewDelegate

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
  // Initialize Main Window
  // ----------------------
  self.window = [[UIWindow alloc] initWithFrame: SCREENFRAME];
  self.window.backgroundColor = VIEWS_BACKGROUND_COLOR;

  //
  // Set App Styles
  // --------------
  
  // Set color status bar text information -- carrier, time, battery text (dark)
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
  
  //
  // Initialize SMG Tab Bar Controller
  // ---------------------------------
  [self makeTabBarController];
  
  //
  // Construct Frame for main views
  // ------------------------------

  // Below status bar, above tab bar
//   self.mainViewFrame = CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT - TABBARHEIGHT);

  // Just below status bar
//  self.mainViewFrame = CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT);

  // Full screen
  self.mainViewFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
  
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
  // Create a colored status bar for all phones except
  // iPhone X and above (notched) 4 and below
  // ----------------------------------------
  [self setStatusBar];
  
  //
  // Configure Main Window
  // ---------------------
  [self.window setRootViewController:self.tabBarController];
  [self.window makeKeyAndVisible];

  
  return YES;
}

- (void) setStatusBar {
   // Draw status bar for iPhones 5,6,7 & 8 only
#ifdef DEBUG
  NSLog(@"Has Notch, %i", [self hasTopNotch]);
#endif
   if(
     [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 // > 4
      && ![self hasTopNotch] // < X
     ) {
    // Bar
    self.statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_BAR_HEIGHT)];
    self.statusBarView.backgroundColor = STATUS_BAR_COLOR;
    [self.tabBarController.view addSubview: self.statusBarView];
    // Line
    UIView* statusBarLineView = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, STATUS_BAR_LINE_SIZE)];
    statusBarLineView.backgroundColor = STATUS_BAR_LINE_COLOR;
    [self.tabBarController.view addSubview: statusBarLineView];
  }
}

//NSString* getDeviceModel(void)
//{
//  static dispatch_once_t onceToken;
//  static NSString *strModelID = nil;
//  dispatch_once(&onceToken, ^{
//#if TARGET_IPHONE_SIMULATOR
//    strModelID = NSProcessInfo.processInfo.environment[@"SIMULATOR_MODEL_IDENTIFIER"];
//#else
//    struct utsname systemInfo;
//    uname(&systemInfo);
//    strModelID = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
//#endif
//  });
//  return strModelID;
//}
//
//// See the `Hardware strings` in https://en.wikipedia.org/wiki/List_of_iOS_devices
//BOOL isIPhoneX(void)
//{
//  NSString *strModelID = getDeviceModel();
//  return [strModelID isEqualToString:@"iPhone10,3"] || [strModelID isEqualToString:@"iPhone10,6"];
//}

//BOOL hasTopNotch (void)
//{
//  NSString *strModelID = getDeviceModel();
//  return [strModelID isEqualToString:@"iPhone10,3"] || [strModelID isEqualToString:@"iPhone10,6"] || // iPhone X
//  [strModelID isEqualToString:@"iPhone11,2"] || [strModelID isEqualToString:@"iPhone11,4"] || [strModelID isEqualToString:@"iPhone11,6"] || // iPhone XS (Max)
//  [strModelID isEqualToString:@"iPhone11,8"]; // iPhone XR
//}

- (BOOL)hasTopNotch {
  if (@available(iOS 11.0, *)) {
    return [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.top > 20.0;
  }
  return  NO;
}


- (void) makeTabBarController {
  
  self.tabBarController = [[SMGTabBarController alloc] init];
  self.tabBarController.delegate = self; // Handle tab bar here in App Delegate

#ifdef DEBUG
  NSLog(@"Has Notch, %i", [self hasTopNotch]);
#endif
  
  if ([self hasTopNotch]) {
    [self.tabBarController.tabBar setHeight: 70.0f];
  } else  {
    [self.tabBarController.tabBar setHeight: TABBARHEIGHT];
  }
  self.tabBarController.tabBar.backgroundView.backgroundColor = TAB_BAR_COLOR;
  
//  self.tabBarController.view.backgroundColor = TAB_BAR_COLOR;
  
}


- (void) setUpTabBarItems {
  
  // Add View Controllers to Tab Bar Controller
  NSArray* controllers = [NSArray arrayWithObjects: self.bikeMapVC, self.busMapVC, self.subwayMapVC, self.mapKitMapVC, self.appInfoVC, nil];
  
  
  // Note: Not really clear BUT this makes the tabBarController create correct number of Tab Bar items, so we can then set up the Tab Bar items and SubMenus in the next step
  
  self.tabBarController.viewControllers = controllers;
  
  
  // SubMenus
  NSArray* bikeMapViews = [NSArray arrayWithObjects: self.bikeMapView, self.bikeMapNightView, nil];
  [self.tabBarController setSubMenuViews:bikeMapViews forTabBarItemAtIndex:0];
  
  NSArray* busMapViews = [NSArray arrayWithObjects: self.busManhattanView, self.busBronxView, self.busBrooklynView, self.busQueensView, self.busStatenIslandView, nil];
  [self.tabBarController setSubMenuViews:busMapViews forTabBarItemAtIndex:1];

  // Uncomment after adding subway night map
//  NSArray* subwayMapViews = [NSArray arrayWithObjects:self.subwayMapView, self.subwayMapNightView, nil];
//  [self.tabBarController setSubMenuViews:subwayMapViews forTabBarItemAtIndex:2];
  
  
  // Setup Tab Bar items
  NSDictionary* unselectedTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:10.5],
                                             NSForegroundColorAttributeName: TAB_ICON_COLOR,
                                             };
  NSDictionary* selectedTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:10.5],
                                           NSForegroundColorAttributeName: TAB_ICON_COLOR_SELECTED,
                                           };
  
  NSArray* tabBarImages = [NSArray arrayWithObjects:
                           [Icons imageOfBicycleFilled],
                           [Icons imageOfBusFilled],
                           [Icons imageOfSubFilled],
                           [Icons imageOfMapFilled],
                           [Icons imageOfInfoFilled],
                           nil];


  UIOffset titlePositionAdjustment = UIOffsetMake(0.0f, 0.0f);
  UIOffset imagePositionAdjustment = UIOffsetMake(0.0f, 0.0f);
  if ([self hasTopNotch]) { // If iPhone X
    // Nudge up tab bar items
    titlePositionAdjustment = UIOffsetMake(0, -2.0f);
    imagePositionAdjustment = UIOffsetMake(0, -8.0f);
  }
  
  NSInteger count = 0;
  for (SMGTabBarItem *item in self.tabBarController.tabBar.items) {
    
    UIImage *unselectedimage = [[tabBarImages objectAtIndex:count ] imageWithColor:TAB_ICON_COLOR];
    UIImage *selectedimage = [[tabBarImages objectAtIndex:count ] imageWithColor:TAB_ICON_COLOR_SELECTED];
    
    
    [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
    [item setUnselectedTitleAttributes:unselectedTextAttributes];
    [item setSelectedTitleAttributes:selectedTextAttributes];
    [item setTitlePositionAdjustment:UIOffsetMake(0, 3.5)];
  // Not needed  [item setTitle:((SMGViewController*)[controllers objectAtIndex:count]).title];
    item.imagePositionAdjustment = imagePositionAdjustment;
    item.titlePositionAdjustment = titlePositionAdjustment;
    count++;
  }
  


  // Make TabBar Line
  UIView *lineAboveTabBar = [[UIView alloc] initWithFrame: CGRectMake(0, -TAB_BAR_LINE_SIZE, SCREEN_WIDTH, TAB_BAR_LINE_SIZE)];
  lineAboveTabBar.backgroundColor = TAB_BAR_LINE_COLOR;
  
  [self.tabBarController.tabBar addSubview: lineAboveTabBar];
  
  // Make half circle centered over subway TabBar item 
//  CGFloat xPos = (SCREEN_WIDTH/2)-35;
//  UIImageView *halfCircleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, -9, 70, 14)];
//  halfCircleImageView.image = [Icons imageOfHalfCircle];
//  [self.tabBarController.tabBar addSubview: halfCircleImageView];

  
}


- (void) makeScrollViews { // These are the maps
  
  //
  // Subway Map Views
  // ---------------
  self.subwayMapView = [[SMGScrollView alloc] initWithTitle:@"DAY" index:0 frame:self.mainViewFrame  imageName:@"2017Sub" imageSize:CGSizeMake(2560.0, 3072.0)];
  [self.subwayMapView setContentOffset:CGPointMake(0, 0) animated:YES];

    // Uncomment after subway night map added
//  self.subwayMapNightView = [[SMGScrollView alloc] initWithTitle:@"NIGHT" index:1 frame:self.mainViewFrame imageName:@"2017SubNight" imageSize:CGSizeMake(2560.0, 3072.0)];
//  [self.subwayMapNightView setContentOffset:CGPointMake(0, 0) animated:YES];
  
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


  
  for (SMGScrollView* view in [NSArray arrayWithObjects: self.busBronxView, self.busBrooklynView, self.busQueensView, self.busStatenIslandView, self.busManhattanView, self.bikeMapNightView, self.bikeMapView, self.subwayMapView, nil] ){ // Add subway night view here after map added
        view.smgdelegate = self;
  }
  
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
  self.appInfoView.backgroundColor = VIEWS_BACKGROUND_COLOR;
  [self.appInfoView setOpaque:NO];
  NSURL *url = [[NSBundle mainBundle] URLForResource:@"app_info" withExtension:@"html"];
  [self.appInfoView loadRequest:[NSURLRequest requestWithURL:url]];
  self.appInfoView.delegate = self;
  self.appInfoView.scrollView.bounces = NO;
  
//  The below is not the best way to register a tap on a webview, instead it seems
//  https://stackoverflow.com/questions/4734682/how-to-detect-touch-on-uiwebview
//  UITapGestureRecognizer *oneFingerTapRecognizer = [[UITapGestureRecognizer alloc]
//                                                    initWithTarget:self.appInfoView
//                                                    action:@selector(appInfoViewTapped:)];
//  oneFingerTapRecognizer.numberOfTapsRequired = 1;
//  oneFingerTapRecognizer.numberOfTouchesRequired = 1;
//  [self.appInfoView.scrollView addGestureRecognizer:oneFingerTapRecognizer];
  
}
//- (void)appInfoViewTapped:(UITapGestureRecognizer*)recognizer {
//#ifdef DEBUG
//  NSLog(@"App Info View Tapped");
//#endif
//  
// [self scrollViewTapped: (SMGScrollView*) self.appInfoView];
//    
//}
 
- (void) makeViewControllers {
  

  UIColor *bgColorForVCs = VIEWS_BACKGROUND_COLOR;
  
  // Bike
  self.bikeMapVC = [[SMGViewController alloc] initWithTabTitle:@"Bike"];
  [self.bikeMapVC.view addSubview: self.bikeMapNightView];
  self.bikeMapView.hidden = false;
  [self.bikeMapVC.view addSubview: self.bikeMapView];
  self.bikeMapVC.view.backgroundColor = bgColorForVCs;
  
  // Subway
  self.subwayMapVC = [[SMGViewController alloc] initWithTabTitle:@"Subway"];
  self.subwayMapView.hidden = false;
  [self.subwayMapVC.view addSubview: self.subwayMapView];
//  [self.subwayMapVC.view addSubview: self.subwayMapNightView]; // Uncomment after adding night view
  self.subwayMapVC.view.backgroundColor = bgColorForVCs;
  
  // Bus
  self.busMapVC = [[SMGViewController alloc] initWithTabTitle:@"Bus"];
  self.busManhattanView.hidden = false;
  for (SMGScrollView* view in [NSArray arrayWithObjects: self.busBronxView, self.busBrooklynView, self.busQueensView, self.busStatenIslandView, self.busManhattanView, nil]) {
    [self.busMapVC.view addSubview: view];    
  }
  self.busMapVC.view.backgroundColor = bgColorForVCs;
  
  // Map
  self.mapKitMapVC = [[SMGViewController alloc] initWithTabTitle:@"Map"];
  [self.mapKitMapVC.view addSubview:self.mapkitMapView];
 
  // About
  self.appInfoVC = [[SMGViewController alloc] initWithTabTitle:@"About" ];
  [self.appInfoVC.view addSubview:self.appInfoView];
  self.appInfoVC.view.backgroundColor = [UIColor colorWithPatternImage:[SMGUtilities imageWithName:@"bg-lt.png" Size:SCREENFRAME.size]];
 
}


- (void) scrollViewTapped: (SMGScrollView*) scrollView {
  
#ifdef DEBUG
    NSLog(@"This view tapped:%@", scrollView.title);
#endif
  if (self.tabBarController.tabBarHidden) {
    [self.tabBarController setTabBarHidden:NO animated:YES];
  } else {
    [self.tabBarController setTabBarHidden:YES animated:YES];
    [self.tabBarController closeSubMenus];
  }
  
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



- (void)applicationWillResignActive:(UIApplication *)application {
  
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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


