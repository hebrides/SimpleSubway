//
//  SMGButton.h
//  simplesubway
//
//  Created by Marcus Skye Lewis on 7/6/14.
//  Copyright (c) 2014 Marcus Lewis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

/*
 This subclass was created to be able to set the background color for UIControlState
 */

@interface SMGButton : UIButton <NSCopying>

{
    
@private
    NSMutableDictionary *backgroundStates;

@public
    
}

- (id)initWithFrame:(CGRect)frame tag:(NSInteger)tag title:(NSString*)title;

@end