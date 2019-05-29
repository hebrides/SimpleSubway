//
//  SMGButton.h
//  simplesubway
//
//  Created by Marcus Skye Lewis on 7/6/14.
//  Copyright (c) 2014 Skye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

/*
 This subclass sets background color for UIControlState
 */

@interface SMGButton : UIButton <NSCopying>

{
    
@private
    NSMutableDictionary *backgroundStates;

@public
    
}

- (id)initWithFrame:(CGRect)    frame
                tag:(NSInteger) index
              title:(NSString*) title;

@end

@protocol SMGButtonDelegate <NSObject>

@end
