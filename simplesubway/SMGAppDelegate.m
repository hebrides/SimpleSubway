//
//  SMGAppDelegate.m
//  NYC Subway Map
//
//  Created by Marcus Lewis on 12/17/13.
//  Copyright (c) 2013 Marcus Lewis. All rights reserved.
//

#import "SMGAppDelegate.h"
#import "SMGScrollView.h"
#import "SMGViewController.h"
#import "SMGUtilities.h"
#import "SMGButton.h"
// #import "SMGMapAnnotation.h"

#define STATUSBARHEIGHT 20.0f


@interface SMGAppDelegate () <UIScrollViewDelegate, UITabBarControllerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate, UIWebViewDelegate>


@property (nonatomic)                  CGRect              mainViewFrame;
@property (nonatomic, strong)          SMGViewController*  subwayMapVC;
@property (nonatomic, strong)          SMGViewController*  busMapVC;
@property (nonatomic, strong)          SMGViewController*  mapKitMapVC;
@property (nonatomic, strong)          SMGViewController*  appInfoVC;

@property (nonatomic, strong)          SMGScrollView*      subwayMapView;
@property (nonatomic, strong)          SMGScrollView*      busBrooklynView;
@property (nonatomic, strong)          SMGScrollView*      busManhattanView;
@property (nonatomic, strong)          SMGScrollView*      busQueensView;
@property (nonatomic, strong)          SMGScrollView*      busBronxView;
@property (nonatomic, strong)          NSArray*            busMapViews;
@property (nonatomic, strong)          UIButton*             busSubMenuView;
@property (nonatomic)                  CGFloat             subMenuHeight;
@property (nonatomic)                  CGFloat             subMenuWidth;
@property (nonatomic)                  CGFloat             subMenuOpenerButtonSize;

@property (nonatomic, strong)          MKMapView*          mapkitMapView;
@property (nonatomic, strong)          UIView*             appInfoView;
@property (nonatomic, strong)          UIWebView*          webView;

@property (nonatomic, strong)          UIView*             fakeStatusBarView;
@property (nonatomic, strong)          UIButton*           openSubMenuButton;
@property (nonatomic, strong)          UIButton*           openTabBarButton;
@property (nonatomic, strong)          UIColor*            menuBGColor;
@property (nonatomic)                  CGPathDrawingMode   drawingMode;
@property (nonatomic)                  BOOL                openSubMenuButtonTouched;
@property (nonatomic)                  BOOL                iOS7;


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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
     self.menuBGColor = [UIColor colorWithRed:247/255.0f green:166/255.0f blue:0/255.0f alpha:1.0f];
    
    //
    // Determine iOS 7
    // ---------------
    self.iOS7 = [SMGUtilities iOS7check];
    
    //
    // Initialize Tab Bar Controller
    // -----------------------------
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = NULL;
    // Don't forget to set delegate
    self.tabBarController.delegate = self;
    
    //
    // Construct frame for views that is below status bar, above tab bar
    // --------------------------------------------------------------------
    self.mainViewFrame = [SMGUtilities getScreenFrameMinusStatusAndTabBars];
    
    //
    // Initialize ScrollViews for Map Images
    // -------------------------------------
    [self makeScrollViews];
    
    //
    // Initialize View Controllers
    // ---------------------------
    [self makeViewControllers];
    
    //
    // Initialize Bus Map Submenu
    // --------------------------
    [self makeBusSubMenu];
    
    //
    // Create bitMask for resizing views (everything except flex bottom margin)
    // Note: This doesn't work well as it seems not to get set fast enough
    // so coding this by hand for now.
    // ------------------------------------------------------------------------
    self.bitMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    //
    // Apply black and white tint for iOS 7
    // ------------------------------------
    if(self.iOS7){
        self.tabBarController.tabBar.barTintColor = [UIColor blackColor];
        self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
        self.tabBarController.tabBar.backgroundColor = [UIColor blackColor];
    }
    
    //
    // Initialize Main Window
    // ----------------------
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //
    // Configure Main Window
    // ---------------------
    [self.window setRootViewController:self.tabBarController];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    // Status Bar Fix iOS 7.0 -- place a fake status bar beneath status info
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) //Another way to determine iOS7+
    {
        
        
        self.fakeStatusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, STATUSBARHEIGHT)];
        self.fakeStatusBarView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        
        /*  for (UIView *subView in self.window.subviews) {
            
            if ([subView isKindOfClass:[UIScrollView class]]) {
                subView.frame = CGRectMake(subView.frame.origin.x, subView.frame.origin.y + STATUSBARHEIGHT, subView.frame.size.width, subView.frame.size.height - STATUSBARHEIGHT);
            } else {
                subView.frame = CGRectMake(subView.frame.origin.x, subView.frame.origin.y + STATUSBARHEIGHT, subView.frame.size.width, subView.frame.size.height);
            }
        }*/

        [self.tabBarController.view addSubview:self.fakeStatusBarView];
        self.fakeStatusBarView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    }

    
    return YES;
}

- (void) makeScrollViews {
    
    //
    // Subway View
    // -----------
    self.subwayMapView = [[SMGScrollView alloc] initWithFrame:self.mainViewFrame imageName:@"subNYC2013" imageSize:CGSizeMake(3360.0, 4012.0)];
    self.subwayMapView.zoomScale = 0.15;
    [self.subwayMapView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    //
    // Bus Views
    // ---------
    self.busManhattanView = [[SMGScrollView alloc] initWithFrame:self.mainViewFrame imageName:@"busManNYC2013" imageSize:CGSizeMake(2000.0, 6144.0)];
    self.busBrooklynView = [[SMGScrollView alloc] initWithFrame:self.mainViewFrame imageName:@"busBklnNYC2013" imageSize:CGSizeMake(4882.0, 5150.0)];
    self.busQueensView = [[SMGScrollView alloc] initWithFrame:self.mainViewFrame imageName:@"busQ2013" imageSize:CGSizeMake(4406.0, 4628.0)];
    self.busBronxView = [[SMGScrollView alloc] initWithFrame:self.mainViewFrame imageName:@"busBx2013" imageSize:CGSizeMake(4320.0, 4562.0)];
    
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
    ctrpoint.latitude = 40.752;
    ctrpoint.longitude =-73.979;
   
    // SMGMapAnnotation *fooAnnotation = [[SMGMapAnnotation alloc] initWithCoordinates:ctrpoint placeName:@"Foo" description:@"Bar"];
    // [self.mapkitMapView addAnnotation:fooAnnotation];
    
    // For showing user location (not yet implemented as a button).
    self.mapkitMapView.delegate =  self;
    self.mapkitMapView.showsUserLocation = YES;
    
    //
    // App Info Webview
    // -----------------
    self.appInfoView = [[UIView alloc] initWithFrame:self.mainViewFrame];
    self.appInfoView.backgroundColor = [UIColor colorWithRed:36/255.0f green:38/255.0f blue:39/255.0f alpha:1.0];
    self.webView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 0, self.mainViewFrame.size.width, self.mainViewFrame.size.height)];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"app_info" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.delegate = self;
    [self.appInfoView addSubview:self.webView];
    
    //
    // Hide unseen views
    // -----------------
    [self.busBrooklynView setHidden:YES];
    [self.busQueensView setHidden:YES];
    [self.busBronxView setHidden:YES];
    
    //
    // Set view flex margins, height & width
    // -------------------------------------
    self.mapkitMapView.autoresizingMask =
    self.subwayMapView.autoresizingMask =
    self.busManhattanView.autoresizingMask = self.bitMask ^ UIViewAutoresizingFlexibleHeight ^ UIViewAutoresizingFlexibleWidth;
    self.appInfoView.autoresizingMask = self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
}

- (void) makeBusSubMenu {
    
    //
    // Position and set up submenu view
    // --------------------------------
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    self.subMenuWidth = [[UIScreen mainScreen] bounds].size.width;// 140.0f;
    NSUInteger numSubMenuButtons = 4;
    self.subMenuOpenerButtonSize = 28.0;
    self.subMenuHeight = (tabBarHeight*numSubMenuButtons)+self.subMenuOpenerButtonSize;
    
    
    //
    // Create the bus submenu view
    // ---------------------------
    self.busSubMenuView = [[UIButton alloc] init];
    self.busSubMenuView.frame = CGRectMake(-self.subMenuWidth+self.subMenuOpenerButtonSize,-self.subMenuHeight+STATUSBARHEIGHT+self.subMenuOpenerButtonSize, self.subMenuWidth, self.subMenuHeight);
    self.busSubMenuView.backgroundColor =  [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    self.busSubMenuView.alpha = 0.4;
    
#pragma mark - SubMenu Opener
    
    //
    // Create bus submenu opener  ☰ + X
    // ---------------------------------
    self.openSubMenuButton = [[UIButton alloc] init];
    self.openSubMenuButton.frame = CGRectMake(self.subMenuWidth-self.subMenuOpenerButtonSize,tabBarHeight*4, self.subMenuOpenerButtonSize, self.subMenuOpenerButtonSize);
    self.openSubMenuButton.titleLabel.font = [UIFont fontWithName:@"Verdana" size:16.0];
    [self.openSubMenuButton setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9] forState:UIControlStateNormal];
    //self.openSubMenuButton.backgroundColor = [UIColor redColor];
    [self.openSubMenuButton setTitle:@"+" forState:UIControlStateNormal];
    //self.openSubMenuButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.openSubMenuButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0,2,0);
    [self.openSubMenuButton addTarget:self action:@selector(openSubMenuButtonTouched:)forControlEvents:UIControlEventTouchUpInside];

    
    //
    // Create buttons for submenu
    // --------------------------
    SMGButton* firstButton = [[SMGButton alloc] initWithFrame:CGRectMake(0.0, 0.0, self.subMenuWidth, tabBarHeight) tag: 0 title:@"   MANHATTAN"];
    //[firstButton setImage:[UIImage imageNamed:@"tab_manhattan.png"] forState:UIControlStateNormal];
    SMGButton* secondButton = [[SMGButton alloc] initWithFrame:CGRectMake(0.0, tabBarHeight, self.subMenuWidth, tabBarHeight) tag:1 title:@"   THE BRONX"];
    SMGButton* thirdButton = [[SMGButton alloc] initWithFrame:CGRectMake(0.0, tabBarHeight*2, self.subMenuWidth, tabBarHeight) tag:2 title:@"   BROOKLYN"];
    SMGButton* fourthButton = [[SMGButton alloc] initWithFrame:CGRectMake(0.0, tabBarHeight*3, self.subMenuWidth, tabBarHeight) tag:3 title:@"   QUEENS"];
    
    //
    // Add buttons to submenu
    // ----------------------
    [self.busSubMenuView addSubview:firstButton];
    [self.busSubMenuView addSubview:secondButton];
    [self.busSubMenuView addSubview:thirdButton];
    [self.busSubMenuView addSubview:fourthButton];
    [self.busSubMenuView addSubview:self.openSubMenuButton];
    [self.busSubMenuView setHidden:YES];
    self.openSubMenuButtonTouched = NO;
    
    //
    // Add submenu as subview of tabBarController
    // ----------------------------------------
    [self.tabBarController.view addSubview:self.busSubMenuView];
    
    //
    // Set flex margin, height & width for buttons and bus submenu
    // -----------------------------------------------------------
    firstButton.autoresizingMask =
    secondButton.autoresizingMask =
    thirdButton.autoresizingMask =
    fourthButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    self.busSubMenuView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |  UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
  
}


- (void) makeViewControllers {
    
    // Subway
    self.subwayMapVC = [[SMGViewController alloc] initwithTitle:@"Subway" tabBarIcon:@"main_tab_train.png" ];
    
    // Bus
    self.busMapVC = [[SMGViewController alloc] initwithTitle:@"Bus" tabBarIcon:@"main_tab_bus.png"];
    [self.busMapVC.view addSubview: self.busManhattanView];
    [self.busMapVC.view addSubview: self.busBrooklynView];
    [self.busMapVC.view addSubview: self.busBronxView];
    [self.busMapVC.view addSubview: self.busQueensView];
    
    // Map
    self.mapKitMapVC = [[SMGViewController alloc] initwithTitle:@"Map" tabBarIcon:@"main_tab_map.png"];
    
    // About
    self.appInfoVC = [[SMGViewController alloc] initwithTitle:@"App Info" tabBarIcon:@"main_tab_gear"];
    
    [self.subwayMapVC.view addSubview: self.subwayMapView];
    [self.mapKitMapVC.view addSubview:self.mapkitMapView];
    [self.appInfoVC.view addSubview:self.appInfoView];
    
    /*
    // BG Image for Tab Bar VC Views
    UIImage* BGImage = [UIImage imageNamed:@"bg.png"];
    UIImageView* BGImageView = [[UIImageView alloc] initWithImage:BGImage];
    BGImageView.frame = [SMGUtilities getScreenFrameMinusStatusAndTabBars];
    BGImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tabBarController.view insertSubview:BGImageView atIndex:0];
     */
    
    // Grey Background
    UIColor* tabViewsBGColor =  [UIColor colorWithRed:36/255.0f green:38/255.0f blue:39/255.0f alpha:1.0];
    self.tabBarController.view.backgroundColor = tabViewsBGColor;
    
    // Add Controllers to Tab Bar Controller
    NSArray* controllers = [NSArray arrayWithObjects: self.subwayMapVC, self.busMapVC, self.mapKitMapVC, self.appInfoVC, nil];
    self.tabBarController.viewControllers = controllers;
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if([viewController.title  isEqual: @"Bus"]) {

        [self.busSubMenuView setHidden:NO];
    }
    else {
        [self.busSubMenuView setHidden:YES];
        [self animateSubMenuVisible:NO animated:YES];
    }
    
}


- (void) subMenuButtonTouched:(UIButton*)button {
    
    #ifdef DEBUG
    NSLog(@"Submenu %@ Button : %li Pressed", button.titleLabel.text, (long)button.tag);
    #endif
    
    //HIDE and SHOW for now... probably better to use swap layers

    [self animateSubMenuVisible:![self subMenuIsVisible] animated:YES];
    switch (button.tag) {
        case 0: {
            [self.busManhattanView setHidden:NO];
            [self.busBronxView setHidden:YES];
            [self.busBrooklynView setHidden:YES];
            [self.busQueensView setHidden:YES]; break; }
        case 1: { [self.busBronxView setHidden:NO];
            [self.busManhattanView setHidden:YES];
            [self.busBrooklynView setHidden:YES];
            [self.busQueensView setHidden:YES]; break; }
        case 2: { [self.busBrooklynView setHidden:NO];
            [self.busManhattanView setHidden:YES];
            [self.busBronxView setHidden:YES];
            [self.busQueensView setHidden:YES]; break; }
        case 3: { [self.busQueensView setHidden:NO];
            [self.busManhattanView setHidden:YES];
            [self.busBronxView setHidden:YES];
            [self.busBrooklynView setHidden:YES]; break;}
        default: break;
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

#pragma mark - SubMenu Opener functions

- (void)openSubMenuButtonTouched:(id)sender {
    
    #if DEBUG
    NSLog(@"openSM");
    NSLog(@"%@", [sender description]);
    #endif
    
    [self animateSubMenuVisible:![self subMenuIsVisible] animated:YES];
}

- (void)animateSubMenuVisible:(BOOL)visible animated:(BOOL)animated {
    
    // check if the current state matches the desired state
    if ([self subMenuIsVisible] == visible) return;
    
    // get a frame calculation ready
    CGRect frame = self.busSubMenuView.frame;
    
    // open subMenuButton [+] (so it "sticks out" subMenuOpenerButtonSize pts)
    CGFloat height = frame.size.height-self.subMenuOpenerButtonSize;
    CGFloat width = frame.size.width-self.subMenuOpenerButtonSize;
    
    CGFloat offsetY = (visible)? height : -height;
    CGFloat offsetX = (visible)? width : -width;
    CGFloat bgAlpha = (visible)? 1.0 : 0.4;
    
    // change submenu button [+], [x]
    NSString* openIcon = (visible)? @"x" : @"+";
    [self.openSubMenuButton setTitle:openIcon forState:UIControlStateNormal];

    // 0.0 (no animation)
    CGFloat duration = (animated)? 0.3 : 0.0;
    
    // animate
    [UIView animateWithDuration:duration animations:^{
        self.busSubMenuView.frame = (visible)? CGRectOffset(frame, offsetX, 0): CGRectOffset(frame, 0, offsetY) ;
        self.busSubMenuView.alpha = bgAlpha;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.busSubMenuView.frame = CGRectOffset(frame, offsetX, offsetY);
        }];
    }];
}


- (BOOL)subMenuIsVisible {
    // If offscreen return false
    return self.busSubMenuView.frame.origin.y >= 0.0f;
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
