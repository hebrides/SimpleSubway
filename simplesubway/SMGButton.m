//
//  SMGButton.m
//  simplesubway
//
//  Created by Marcus Skye Lewis on 7/6/14.
//  Copyright (c) 2014 Bolt Action. All rights reserved.
//

#import "SMGButton.h"
#import "SMGAppDelegate.h"

@implementation SMGButton

- (id)initWithFrame:(CGRect)    frame
                tag:(NSInteger) tag
              title:(NSString*) title
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      UIColor* menuBG = SUBMENU_BACKGROUND_COLOR;
        UIColor* menuText = SUBMENU_TEXT_COLOR;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0];
       // self.titleLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:14.0];
        self.tag = tag;
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:menuText forState:UIControlStateNormal];
        [self setTitleColor:menuBG forState:UIControlStateHighlighted];
        

        
        // Apple doesn't let you set the buttonhighlighted bgcolor
        // so we'll make an image with the color we want
        // -----------------------------------------------------------------------------
        
        CGSize bgColorRect = CGSizeMake(frame.size.width, frame.size.height);
//      UIColor *bgColor = SUBMENU_TOUCH_COLOR; // Uncomment for solid fill
        UIGraphicsBeginImageContext(bgColorRect);
//      CGContextRef context = UIGraphicsGetCurrentContext();
//      CGContextSetFillColorWithColor(context, bgColor.CGColor); // Uncomment for solid fill
//      CGContextFillRect(context, (CGRect){.size = bgColorRect}); // Uncomment for solid fill
    
        // Gradient Fill
        CAGradientLayer* gradientLayer = [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0.5, 0);
        gradientLayer.endPoint = CGPointMake(0.5,1);
        gradientLayer.frame = (CGRect){.size = bgColorRect};
        gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[SUBMENU_TOUCH_COLOR CGColor], nil];
        [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
        // Comment out above code for solid fill

        UIImage *bgColorImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self setBackgroundImage:bgColorImage forState:UIControlStateHighlighted];
      
      
    
    
        /*
        //set the shadow on the view's layer
        [self setClipsToBounds:NO];
        [[self layer] setShadowColor:[[UIColor blackColor] CGColor]];
        [[self layer] setShadowOffset:CGSizeMake(0, 6)];
        [[self layer] setShadowOpacity:1.0];
        [[self layer] setShadowRadius:20.0];
         */
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(id)copyWithZone:(NSZone *)zone
{
    SMGButton *buttonCopy = [[SMGButton alloc] init];
    // add copy code here
    
    // ...
    
    
    return buttonCopy;
}

@end
