//
//  SMGButton.m
//  simplesubway
//
//  Created by Marcus Skye Lewis on 7/6/14.
//  Copyright (c) 2014 Marcus Lewis. All rights reserved.
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
        UIColor* menuBlack = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.70];
        UIColor* menuWhite = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.98];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //self.titleLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:14.0];
        self.titleLabel.font = [UIFont fontWithName:@"Futura" size:14.0];
        self.tag = tag;
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:menuWhite forState:UIControlStateNormal];
        [self setTitleColor:menuBlack forState:UIControlStateHighlighted];
        
        // Tell the App Delegate to do something when button pressed (Not yet optimized into full menu class)
        SMGAppDelegate* delegate = (SMGAppDelegate*) [[UIApplication sharedApplication] delegate];
        [self addTarget:delegate action:@selector(busMenuButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        // Apple doesn't let you set the buttonhighlighted bgcolor
        // so we'll make an image with the correct color:
        // orange = 255,180,0 ; yellow = 255,221,0 ; gray = 180,180,180
        // ----------------------------------------------------------------------
        
        CGSize bgColorRect = CGSizeMake(frame.size.width, frame.size.height);
        UIColor *bgColor = [UIColor colorWithRed:255/255.0f green:180/255.0f blue:0/255.0f alpha:1.0f];
        UIGraphicsBeginImageContext(bgColorRect);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, bgColor.CGColor);
        CGContextFillRect(context, (CGRect){.size = bgColorRect});
        
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
