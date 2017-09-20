//
//  SMGViewController.h
//  Marcus
//
//  Created by Marcus Skye Lewis on 11/7/15.
//  Copyright © 2015 SMGMobile. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>




@interface SMGViewController : UIViewController

//@property (nonatomic, strong)       SMGViewHeader*      viewHeader;
//@property (nonatomic, strong)       SMGModel*           appModel;


// SMG TabBar Controller uses Title to set TabBar ItemNames.
// Therefore create viewHeaderTitle attribute so NavBar title can be different value

-(id) initWithTabTitle:(NSString*)tabTitle;

//-(id) initWithTabTitle:(NSString*)tabTitle headerTitle:(NSString*)headerTitle modelObject:(SMGModel*)modelObject;
@end
