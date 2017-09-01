//
//  Icons.m
//  Simple Subway
//
//  Created by Marcus Lewis on 8/14/17.
//  Copyright © 2017 SMG Mobile. All rights reserved.
//
//  Generated by PaintCode Plugin for Sketch
//  http://www.paintcodeapp.com/sketch
//

@import UIKit;
#import "Icons.h"



@implementation Icons


#pragma mark - Canvas Drawings

//! Page 1

+ (void)drawInfoFilled {
    [Icons drawInfoFilledWithFrame:CGRectMake(0, 0, 11, 25) resizing:IconsResizingBehaviorAspectFit];
}
+ (void)drawInfoFilledWithFrame:(CGRect)targetFrame resizing:(IconsResizingBehavior)resizing {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = IconsResizingBehaviorApply(resizing, CGRectMake(0, 0, 11, 25), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 11, resizedFrame.size.height / 25);
    
    //! info
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 1, 4);
        
        //! Shape
        UIBezierPath *shape = [UIBezierPath bezierPath];
        [shape moveToPoint:CGPointMake(7.76, 17.84)];
        [shape addLineToPoint:CGPointMake(7.51, 18.98)];
        [shape addCurveToPoint:CGPointMake(5.69, 19.74) controlPoint1:CGPointMake(6.75, 19.31) controlPoint2:CGPointMake(6.14, 19.57)];
        [shape addCurveToPoint:CGPointMake(4.12, 20) controlPoint1:CGPointMake(5.24, 19.91) controlPoint2:CGPointMake(4.71, 20)];
        [shape addCurveToPoint:CGPointMake(1.97, 19.26) controlPoint1:CGPointMake(3.2, 20) controlPoint2:CGPointMake(2.48, 19.75)];
        [shape addCurveToPoint:CGPointMake(1.21, 17.37) controlPoint1:CGPointMake(1.46, 18.76) controlPoint2:CGPointMake(1.21, 18.13)];
        [shape addCurveToPoint:CGPointMake(1.26, 16.46) controlPoint1:CGPointMake(1.21, 17.08) controlPoint2:CGPointMake(1.23, 16.77)];
        [shape addCurveToPoint:CGPointMake(1.45, 15.42) controlPoint1:CGPointMake(1.3, 16.15) controlPoint2:CGPointMake(1.37, 15.81)];
        [shape addLineToPoint:CGPointMake(2.4, 11.71)];
        [shape addCurveToPoint:CGPointMake(2.61, 10.7) controlPoint1:CGPointMake(2.48, 11.35) controlPoint2:CGPointMake(2.55, 11.02)];
        [shape addCurveToPoint:CGPointMake(2.7, 9.83) controlPoint1:CGPointMake(2.67, 10.38) controlPoint2:CGPointMake(2.7, 10.09)];
        [shape addCurveToPoint:CGPointMake(2.43, 8.84) controlPoint1:CGPointMake(2.7, 9.36) controlPoint2:CGPointMake(2.61, 9.02)];
        [shape addCurveToPoint:CGPointMake(1.42, 8.56) controlPoint1:CGPointMake(2.26, 8.65) controlPoint2:CGPointMake(1.92, 8.56)];
        [shape addCurveToPoint:CGPointMake(0.66, 8.68) controlPoint1:CGPointMake(1.17, 8.56) controlPoint2:CGPointMake(0.92, 8.6)];
        [shape addCurveToPoint:CGPointMake(0, 8.93) controlPoint1:CGPointMake(0.41, 8.77) controlPoint2:CGPointMake(0.19, 8.85)];
        [shape addLineToPoint:CGPointMake(0.25, 7.78)];
        [shape addCurveToPoint:CGPointMake(2.04, 7.07) controlPoint1:CGPointMake(0.87, 7.5) controlPoint2:CGPointMake(1.47, 7.26)];
        [shape addCurveToPoint:CGPointMake(3.65, 6.77) controlPoint1:CGPointMake(2.61, 6.87) controlPoint2:CGPointMake(3.14, 6.77)];
        [shape addCurveToPoint:CGPointMake(5.76, 7.5) controlPoint1:CGPointMake(4.56, 6.77) controlPoint2:CGPointMake(5.27, 7.01)];
        [shape addCurveToPoint:CGPointMake(6.5, 9.4) controlPoint1:CGPointMake(6.26, 7.99) controlPoint2:CGPointMake(6.5, 8.62)];
        [shape addCurveToPoint:CGPointMake(6.45, 10.25) controlPoint1:CGPointMake(6.5, 9.56) controlPoint2:CGPointMake(6.49, 9.84)];
        [shape addCurveToPoint:CGPointMake(6.26, 11.37) controlPoint1:CGPointMake(6.42, 10.65) controlPoint2:CGPointMake(6.35, 11.03)];
        [shape addLineToPoint:CGPointMake(5.32, 15.06)];
        [shape addCurveToPoint:CGPointMake(5.11, 16.08) controlPoint1:CGPointMake(5.24, 15.36) controlPoint2:CGPointMake(5.17, 15.69)];
        [shape addCurveToPoint:CGPointMake(5.02, 16.94) controlPoint1:CGPointMake(5.05, 16.46) controlPoint2:CGPointMake(5.02, 16.74)];
        [shape addCurveToPoint:CGPointMake(5.31, 17.94) controlPoint1:CGPointMake(5.02, 17.43) controlPoint2:CGPointMake(5.12, 17.76)];
        [shape addCurveToPoint:CGPointMake(6.35, 18.21) controlPoint1:CGPointMake(5.51, 18.12) controlPoint2:CGPointMake(5.86, 18.21)];
        [shape addCurveToPoint:CGPointMake(7.13, 18.08) controlPoint1:CGPointMake(6.58, 18.21) controlPoint2:CGPointMake(6.84, 18.16)];
        [shape addCurveToPoint:CGPointMake(7.76, 17.84) controlPoint1:CGPointMake(7.42, 17.99) controlPoint2:CGPointMake(7.63, 17.91)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(8, 2.34)];
        [shape addCurveToPoint:CGPointMake(7.34, 3.98) controlPoint1:CGPointMake(8, 2.98) controlPoint2:CGPointMake(7.78, 3.53)];
        [shape addCurveToPoint:CGPointMake(5.75, 4.66) controlPoint1:CGPointMake(6.9, 4.43) controlPoint2:CGPointMake(6.37, 4.66)];
        [shape addCurveToPoint:CGPointMake(4.15, 3.98) controlPoint1:CGPointMake(5.13, 4.66) controlPoint2:CGPointMake(4.59, 4.43)];
        [shape addCurveToPoint:CGPointMake(3.48, 2.34) controlPoint1:CGPointMake(3.71, 3.53) controlPoint2:CGPointMake(3.48, 2.98)];
        [shape addCurveToPoint:CGPointMake(4.15, 0.69) controlPoint1:CGPointMake(3.48, 1.69) controlPoint2:CGPointMake(3.71, 1.14)];
        [shape addCurveToPoint:CGPointMake(5.75, 0) controlPoint1:CGPointMake(4.59, 0.23) controlPoint2:CGPointMake(5.13, 0)];
        [shape addCurveToPoint:CGPointMake(7.34, 0.69) controlPoint1:CGPointMake(6.37, 0) controlPoint2:CGPointMake(6.9, 0.23)];
        [shape addCurveToPoint:CGPointMake(8, 2.34) controlPoint1:CGPointMake(7.78, 1.14) controlPoint2:CGPointMake(8, 1.69)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(8, 2.34)];
        CGContextSaveGState(context);
        [[UIColor colorWithHue:0.118 saturation:0.751 brightness:0.929 alpha:1] setFill];
        [shape fill];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    
    CGContextRestoreGState(context);
}

+ (void)drawMapFilled {
    [Icons drawMapFilledWithFrame:CGRectMake(0, 0, 15, 25) resizing:IconsResizingBehaviorAspectFit];
}
+ (void)drawMapFilledWithFrame:(CGRect)targetFrame resizing:(IconsResizingBehavior)resizing {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = IconsResizingBehaviorApply(resizing, CGRectMake(0, 0, 15, 25), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 15, resizedFrame.size.height / 25);
    
    //! locate
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 1, 4);
        
        //! Shape
        UIBezierPath *shape = [UIBezierPath bezierPath];
        [shape moveToPoint:CGPointMake(6.5, 0)];
        [shape addCurveToPoint:CGPointMake(0, 6.67) controlPoint1:CGPointMake(2.92, 0) controlPoint2:CGPointMake(0, 2.99)];
        [shape addCurveToPoint:CGPointMake(0.78, 9.83) controlPoint1:CGPointMake(0, 7.77) controlPoint2:CGPointMake(0.27, 8.86)];
        [shape addLineToPoint:CGPointMake(6.14, 19.79)];
        [shape addCurveToPoint:CGPointMake(6.5, 20) controlPoint1:CGPointMake(6.22, 19.92) controlPoint2:CGPointMake(6.35, 20)];
        [shape addCurveToPoint:CGPointMake(6.86, 19.79) controlPoint1:CGPointMake(6.65, 20) controlPoint2:CGPointMake(6.78, 19.92)];
        [shape addLineToPoint:CGPointMake(12.22, 9.83)];
        [shape addCurveToPoint:CGPointMake(13, 6.67) controlPoint1:CGPointMake(12.73, 8.86) controlPoint2:CGPointMake(13, 7.77)];
        [shape addCurveToPoint:CGPointMake(6.5, 0) controlPoint1:CGPointMake(13, 2.99) controlPoint2:CGPointMake(10.08, 0)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(6.5, 10)];
        [shape addCurveToPoint:CGPointMake(3.25, 6.67) controlPoint1:CGPointMake(4.71, 10) controlPoint2:CGPointMake(3.25, 8.5)];
        [shape addCurveToPoint:CGPointMake(6.5, 3.33) controlPoint1:CGPointMake(3.25, 4.83) controlPoint2:CGPointMake(4.71, 3.33)];
        [shape addCurveToPoint:CGPointMake(9.75, 6.67) controlPoint1:CGPointMake(8.29, 3.33) controlPoint2:CGPointMake(9.75, 4.83)];
        [shape addCurveToPoint:CGPointMake(6.5, 10) controlPoint1:CGPointMake(9.75, 8.5) controlPoint2:CGPointMake(8.29, 10)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(6.5, 10)];
        CGContextSaveGState(context);
        [[UIColor colorWithHue:0.118 saturation:0.751 brightness:0.929 alpha:1] setFill];
        [shape fill];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    
    CGContextRestoreGState(context);
}

+ (void)drawSubFilled {
    [Icons drawSubFilledWithFrame:CGRectMake(0, 0, 20, 25) resizing:IconsResizingBehaviorAspectFit];
}
+ (void)drawSubFilledWithFrame:(CGRect)targetFrame resizing:(IconsResizingBehavior)resizing {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = IconsResizingBehaviorApply(resizing, CGRectMake(0, 0, 20, 25), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 20, resizedFrame.size.height / 25);
    
    //! subway
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 1, 3);
        
        //! Shape
        UIBezierPath *shape = [UIBezierPath bezierPath];
        [shape moveToPoint:CGPointMake(9, 0)];
        [shape addCurveToPoint:CGPointMake(0, 4.42) controlPoint1:CGPointMake(4.05, 0) controlPoint2:CGPointMake(0, 0.55)];
        [shape addLineToPoint:CGPointMake(0, 14.92)];
        [shape addCurveToPoint:CGPointMake(3.94, 18.79) controlPoint1:CGPointMake(0, 17.02) controlPoint2:CGPointMake(1.8, 18.79)];
        [shape addLineToPoint:CGPointMake(2.25, 20.45)];
        [shape addLineToPoint:CGPointMake(2.25, 21)];
        [shape addLineToPoint:CGPointMake(15.75, 21)];
        [shape addLineToPoint:CGPointMake(15.75, 20.45)];
        [shape addLineToPoint:CGPointMake(14.06, 18.79)];
        [shape addCurveToPoint:CGPointMake(18, 14.92) controlPoint1:CGPointMake(16.2, 18.79) controlPoint2:CGPointMake(18, 17.02)];
        [shape addLineToPoint:CGPointMake(18, 4.42)];
        [shape addCurveToPoint:CGPointMake(9, 0) controlPoint1:CGPointMake(18, 0.55) controlPoint2:CGPointMake(13.95, 0)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(3.94, 16.58)];
        [shape addCurveToPoint:CGPointMake(2.25, 14.92) controlPoint1:CGPointMake(3.04, 16.58) controlPoint2:CGPointMake(2.25, 15.81)];
        [shape addCurveToPoint:CGPointMake(3.94, 13.26) controlPoint1:CGPointMake(2.25, 14.04) controlPoint2:CGPointMake(3.04, 13.26)];
        [shape addCurveToPoint:CGPointMake(5.63, 14.92) controlPoint1:CGPointMake(4.84, 13.26) controlPoint2:CGPointMake(5.63, 14.04)];
        [shape addCurveToPoint:CGPointMake(3.94, 16.58) controlPoint1:CGPointMake(5.63, 15.81) controlPoint2:CGPointMake(4.84, 16.58)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(7.88, 9.95)];
        [shape addLineToPoint:CGPointMake(2.25, 9.95)];
        [shape addLineToPoint:CGPointMake(2.25, 4.42)];
        [shape addLineToPoint:CGPointMake(7.88, 4.42)];
        [shape addLineToPoint:CGPointMake(7.88, 9.95)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(14.06, 16.58)];
        [shape addCurveToPoint:CGPointMake(12.38, 14.92) controlPoint1:CGPointMake(13.16, 16.58) controlPoint2:CGPointMake(12.38, 15.81)];
        [shape addCurveToPoint:CGPointMake(14.06, 13.26) controlPoint1:CGPointMake(12.38, 14.04) controlPoint2:CGPointMake(13.16, 13.26)];
        [shape addCurveToPoint:CGPointMake(15.75, 14.92) controlPoint1:CGPointMake(14.96, 13.26) controlPoint2:CGPointMake(15.75, 14.04)];
        [shape addCurveToPoint:CGPointMake(14.06, 16.58) controlPoint1:CGPointMake(15.75, 15.81) controlPoint2:CGPointMake(14.96, 16.58)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(15.75, 9.95)];
        [shape addLineToPoint:CGPointMake(10.13, 9.95)];
        [shape addLineToPoint:CGPointMake(10.13, 4.42)];
        [shape addLineToPoint:CGPointMake(15.75, 4.42)];
        [shape addLineToPoint:CGPointMake(15.75, 9.95)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(15.75, 9.95)];
        CGContextSaveGState(context);
        [[UIColor colorWithHue:0.118 saturation:0.751 brightness:0.929 alpha:1] setFill];
        [shape fill];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    
    CGContextRestoreGState(context);
}

+ (void)drawBusFilled {
    [Icons drawBusFilledWithFrame:CGRectMake(0, 0, 34, 25) resizing:IconsResizingBehaviorAspectFit];
}
+ (void)drawBusFilledWithFrame:(CGRect)targetFrame resizing:(IconsResizingBehavior)resizing {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = IconsResizingBehaviorApply(resizing, CGRectMake(0, 0, 34, 25), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 34, resizedFrame.size.height / 25);
    
    //! Group
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 1, 5);
        
        //! bus
        {
            CGContextSaveGState(context);
            
            //! Shape
            UIBezierPath *shape = [UIBezierPath bezierPath];
            [shape moveToPoint:CGPointMake(2.97, 0)];
            [shape addCurveToPoint:CGPointMake(0, 2.96) controlPoint1:CGPointMake(1.33, 0) controlPoint2:CGPointMake(0, 1.32)];
            [shape addCurveToPoint:CGPointMake(2.97, 5.92) controlPoint1:CGPointMake(0, 4.6) controlPoint2:CGPointMake(1.33, 5.92)];
            [shape addCurveToPoint:CGPointMake(5.94, 2.96) controlPoint1:CGPointMake(4.61, 5.92) controlPoint2:CGPointMake(5.94, 4.6)];
            [shape addCurveToPoint:CGPointMake(2.97, 0) controlPoint1:CGPointMake(5.94, 1.32) controlPoint2:CGPointMake(4.61, 0)];
            [shape closePath];
            [shape moveToPoint:CGPointMake(2.97, 4.25)];
            [shape addCurveToPoint:CGPointMake(1.68, 2.96) controlPoint1:CGPointMake(2.26, 4.25) controlPoint2:CGPointMake(1.68, 3.67)];
            [shape addCurveToPoint:CGPointMake(2.97, 1.67) controlPoint1:CGPointMake(1.68, 2.25) controlPoint2:CGPointMake(2.26, 1.67)];
            [shape addCurveToPoint:CGPointMake(4.26, 2.96) controlPoint1:CGPointMake(3.68, 1.67) controlPoint2:CGPointMake(4.26, 2.25)];
            [shape addCurveToPoint:CGPointMake(2.97, 4.25) controlPoint1:CGPointMake(4.26, 3.67) controlPoint2:CGPointMake(3.68, 4.25)];
            [shape closePath];
            [shape moveToPoint:CGPointMake(2.97, 4.25)];
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 4.11, 12.05);
            [[UIColor colorWithHue:0.118 saturation:0.751 brightness:0.929 alpha:1] setFill];
            [shape fill];
            CGContextRestoreGState(context);
            
            //! Shape
            UIBezierPath *shape2 = [UIBezierPath bezierPath];
            [shape2 moveToPoint:CGPointMake(2.97, 0)];
            [shape2 addCurveToPoint:CGPointMake(0, 2.96) controlPoint1:CGPointMake(1.33, 0) controlPoint2:CGPointMake(0, 1.32)];
            [shape2 addCurveToPoint:CGPointMake(2.97, 5.92) controlPoint1:CGPointMake(0, 4.6) controlPoint2:CGPointMake(1.33, 5.92)];
            [shape2 addCurveToPoint:CGPointMake(5.94, 2.96) controlPoint1:CGPointMake(4.61, 5.92) controlPoint2:CGPointMake(5.94, 4.6)];
            [shape2 addCurveToPoint:CGPointMake(2.97, 0) controlPoint1:CGPointMake(5.94, 1.32) controlPoint2:CGPointMake(4.61, 0)];
            [shape2 closePath];
            [shape2 moveToPoint:CGPointMake(2.97, 4.25)];
            [shape2 addCurveToPoint:CGPointMake(1.68, 2.96) controlPoint1:CGPointMake(2.26, 4.25) controlPoint2:CGPointMake(1.68, 3.67)];
            [shape2 addCurveToPoint:CGPointMake(2.97, 1.67) controlPoint1:CGPointMake(1.68, 2.25) controlPoint2:CGPointMake(2.26, 1.67)];
            [shape2 addCurveToPoint:CGPointMake(4.26, 2.96) controlPoint1:CGPointMake(3.68, 1.67) controlPoint2:CGPointMake(4.26, 2.25)];
            [shape2 addCurveToPoint:CGPointMake(2.97, 4.25) controlPoint1:CGPointMake(4.26, 3.67) controlPoint2:CGPointMake(3.68, 4.25)];
            [shape2 closePath];
            [shape2 moveToPoint:CGPointMake(2.97, 4.25)];
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 21.54, 12.05);
            [[UIColor colorWithHue:0.118 saturation:0.751 brightness:0.929 alpha:1] setFill];
            [shape2 fill];
            CGContextRestoreGState(context);
            
            //! Shape
            UIBezierPath *shape3 = [UIBezierPath bezierPath];
            [shape3 moveToPoint:CGPointMake(30.18, 0)];
            [shape3 addLineToPoint:CGPointMake(3.55, 0)];
            [shape3 addCurveToPoint:CGPointMake(1.42, 1.73) controlPoint1:CGPointMake(2.57, 0) controlPoint2:CGPointMake(1.61, 0.78)];
            [shape3 addLineToPoint:CGPointMake(0.35, 5.61)];
            [shape3 addCurveToPoint:CGPointMake(0, 9.11) controlPoint1:CGPointMake(0.16, 6.56) controlPoint2:CGPointMake(0, 8.14)];
            [shape3 addLineToPoint:CGPointMake(0, 13.18)];
            [shape3 addCurveToPoint:CGPointMake(1.77, 14.95) controlPoint1:CGPointMake(0, 14.15) controlPoint2:CGPointMake(0.8, 14.95)];
            [shape3 addLineToPoint:CGPointMake(3.58, 14.95)];
            [shape3 addCurveToPoint:CGPointMake(7.08, 11.46) controlPoint1:CGPointMake(3.58, 13.02) controlPoint2:CGPointMake(5.15, 11.46)];
            [shape3 addCurveToPoint:CGPointMake(10.58, 14.95) controlPoint1:CGPointMake(9.01, 11.46) controlPoint2:CGPointMake(10.58, 13.02)];
            [shape3 addLineToPoint:CGPointMake(21.01, 14.95)];
            [shape3 addCurveToPoint:CGPointMake(24.51, 11.46) controlPoint1:CGPointMake(21.01, 13.02) controlPoint2:CGPointMake(22.58, 11.46)];
            [shape3 addCurveToPoint:CGPointMake(28.01, 14.95) controlPoint1:CGPointMake(26.44, 11.46) controlPoint2:CGPointMake(28.01, 13.02)];
            [shape3 addLineToPoint:CGPointMake(30.18, 14.95)];
            [shape3 addCurveToPoint:CGPointMake(31.95, 13.18) controlPoint1:CGPointMake(31.15, 14.95) controlPoint2:CGPointMake(31.95, 14.15)];
            [shape3 addLineToPoint:CGPointMake(31.95, 1.77)];
            [shape3 addCurveToPoint:CGPointMake(30.18, 0) controlPoint1:CGPointMake(31.95, 0.8) controlPoint2:CGPointMake(31.15, 0)];
            [shape3 closePath];
            [shape3 moveToPoint:CGPointMake(7.37, 7.46)];
            [shape3 addLineToPoint:CGPointMake(3.24, 7.46)];
            [shape3 addLineToPoint:CGPointMake(3.89, 5.92)];
            [shape3 addCurveToPoint:CGPointMake(3.61, 5.22) controlPoint1:CGPointMake(4.01, 5.65) controlPoint2:CGPointMake(3.88, 5.33)];
            [shape3 addCurveToPoint:CGPointMake(2.91, 5.5) controlPoint1:CGPointMake(3.34, 5.11) controlPoint2:CGPointMake(3.03, 5.23)];
            [shape3 addLineToPoint:CGPointMake(2.1, 7.42)];
            [shape3 addCurveToPoint:CGPointMake(1.33, 6.16) controlPoint1:CGPointMake(1.55, 7.28) controlPoint2:CGPointMake(1.22, 6.77)];
            [shape3 addLineToPoint:CGPointMake(2.28, 2.36)];
            [shape3 addCurveToPoint:CGPointMake(3.86, 1.06) controlPoint1:CGPointMake(2.42, 1.65) controlPoint2:CGPointMake(3.13, 1.06)];
            [shape3 addLineToPoint:CGPointMake(7.37, 1.06)];
            [shape3 addLineToPoint:CGPointMake(7.37, 7.46)];
            [shape3 addLineToPoint:CGPointMake(7.37, 7.46)];
            [shape3 closePath];
            [shape3 moveToPoint:CGPointMake(15.27, 7.46)];
            [shape3 addLineToPoint:CGPointMake(8.44, 7.46)];
            [shape3 addLineToPoint:CGPointMake(8.44, 1.06)];
            [shape3 addLineToPoint:CGPointMake(15.27, 1.06)];
            [shape3 addLineToPoint:CGPointMake(15.27, 7.46)];
            [shape3 addLineToPoint:CGPointMake(15.27, 7.46)];
            [shape3 closePath];
            [shape3 moveToPoint:CGPointMake(23.16, 7.46)];
            [shape3 addLineToPoint:CGPointMake(16.33, 7.46)];
            [shape3 addLineToPoint:CGPointMake(16.33, 1.06)];
            [shape3 addLineToPoint:CGPointMake(23.16, 1.06)];
            [shape3 addLineToPoint:CGPointMake(23.16, 7.46)];
            [shape3 addLineToPoint:CGPointMake(23.16, 7.46)];
            [shape3 closePath];
            [shape3 moveToPoint:CGPointMake(30.86, 6.14)];
            [shape3 addCurveToPoint:CGPointMake(29.53, 7.46) controlPoint1:CGPointMake(30.86, 6.87) controlPoint2:CGPointMake(30.26, 7.46)];
            [shape3 addLineToPoint:CGPointMake(24.22, 7.46)];
            [shape3 addLineToPoint:CGPointMake(24.22, 1.06)];
            [shape3 addLineToPoint:CGPointMake(29.53, 1.06)];
            [shape3 addCurveToPoint:CGPointMake(30.86, 2.39) controlPoint1:CGPointMake(30.26, 1.06) controlPoint2:CGPointMake(30.86, 1.66)];
            [shape3 addLineToPoint:CGPointMake(30.86, 6.14)];
            [shape3 closePath];
            [shape3 moveToPoint:CGPointMake(30.86, 6.14)];
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, -0, 0.07);
            [[UIColor colorWithHue:0.118 saturation:0.751 brightness:0.929 alpha:1] setFill];
            [shape3 fill];
            CGContextRestoreGState(context);
            
            CGContextRestoreGState(context);
        }
        
        CGContextRestoreGState(context);
    }
    
    CGContextRestoreGState(context);
}

+ (void)drawBicycleFilled {
    [Icons drawBicycleFilledWithFrame:CGRectMake(0, 0, 25, 25) resizing:IconsResizingBehaviorAspectFit];
}
+ (void)drawBicycleFilledWithFrame:(CGRect)targetFrame resizing:(IconsResizingBehavior)resizing {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Resize to Target Frame
    CGContextSaveGState(context);
    CGRect resizedFrame = IconsResizingBehaviorApply(resizing, CGRectMake(0, 0, 25, 25), targetFrame);
    CGContextTranslateCTM(context, resizedFrame.origin.x, resizedFrame.origin.y);
    CGContextScaleCTM(context, resizedFrame.size.width / 25, resizedFrame.size.height / 25);
    
    //! bike
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 1, 3);
        
        //! Shape
        UIBezierPath *shape = [UIBezierPath bezierPath];
        [shape moveToPoint:CGPointMake(15.33, 3.45)];
        [shape addCurveToPoint:CGPointMake(17.06, 1.73) controlPoint1:CGPointMake(16.29, 3.45) controlPoint2:CGPointMake(17.06, 2.68)];
        [shape addCurveToPoint:CGPointMake(15.33, 0) controlPoint1:CGPointMake(17.06, 0.77) controlPoint2:CGPointMake(16.29, 0)];
        [shape addCurveToPoint:CGPointMake(13.61, 1.73) controlPoint1:CGPointMake(14.38, 0) controlPoint2:CGPointMake(13.61, 0.77)];
        [shape addCurveToPoint:CGPointMake(15.33, 3.45) controlPoint1:CGPointMake(13.61, 2.68) controlPoint2:CGPointMake(14.38, 3.45)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(18.21, 10.35)];
        [shape addCurveToPoint:CGPointMake(13.42, 15.15) controlPoint1:CGPointMake(15.53, 10.35) controlPoint2:CGPointMake(13.42, 12.46)];
        [shape addCurveToPoint:CGPointMake(18.21, 19.94) controlPoint1:CGPointMake(13.42, 17.83) controlPoint2:CGPointMake(15.53, 19.94)];
        [shape addCurveToPoint:CGPointMake(23, 15.15) controlPoint1:CGPointMake(20.89, 19.94) controlPoint2:CGPointMake(23, 17.83)];
        [shape addCurveToPoint:CGPointMake(18.21, 10.35) controlPoint1:CGPointMake(23, 12.46) controlPoint2:CGPointMake(20.89, 10.35)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(18.21, 18.5)];
        [shape addCurveToPoint:CGPointMake(14.85, 15.15) controlPoint1:CGPointMake(16.39, 18.5) controlPoint2:CGPointMake(14.85, 16.97)];
        [shape addCurveToPoint:CGPointMake(18.21, 11.79) controlPoint1:CGPointMake(14.85, 13.33) controlPoint2:CGPointMake(16.39, 11.79)];
        [shape addCurveToPoint:CGPointMake(21.56, 15.15) controlPoint1:CGPointMake(20.03, 11.79) controlPoint2:CGPointMake(21.56, 13.33)];
        [shape addCurveToPoint:CGPointMake(18.21, 18.5) controlPoint1:CGPointMake(21.56, 16.97) controlPoint2:CGPointMake(20.03, 18.5)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(14.18, 8.44)];
        [shape addLineToPoint:CGPointMake(18.21, 8.44)];
        [shape addLineToPoint:CGPointMake(18.21, 6.71)];
        [shape addLineToPoint:CGPointMake(15.14, 6.71)];
        [shape addLineToPoint:CGPointMake(13.32, 3.55)];
        [shape addCurveToPoint:CGPointMake(11.88, 2.78) controlPoint1:CGPointMake(13.03, 3.07) controlPoint2:CGPointMake(12.55, 2.78)];
        [shape addCurveToPoint:CGPointMake(10.73, 3.26) controlPoint1:CGPointMake(11.4, 2.78) controlPoint2:CGPointMake(11.02, 2.97)];
        [shape addLineToPoint:CGPointMake(7.19, 6.81)];
        [shape addCurveToPoint:CGPointMake(6.71, 7.96) controlPoint1:CGPointMake(6.9, 7.09) controlPoint2:CGPointMake(6.71, 7.48)];
        [shape addCurveToPoint:CGPointMake(7.48, 9.39) controlPoint1:CGPointMake(6.71, 8.53) controlPoint2:CGPointMake(7, 9.11)];
        [shape addLineToPoint:CGPointMake(10.73, 11.31)];
        [shape addLineToPoint:CGPointMake(10.73, 16.11)];
        [shape addLineToPoint:CGPointMake(12.46, 16.11)];
        [shape addLineToPoint:CGPointMake(12.46, 9.87)];
        [shape addLineToPoint:CGPointMake(10.35, 8.24)];
        [shape addLineToPoint:CGPointMake(12.55, 6.04)];
        [shape addLineToPoint:CGPointMake(14.18, 8.44)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(4.79, 10.35)];
        [shape addCurveToPoint:CGPointMake(0, 15.15) controlPoint1:CGPointMake(2.11, 10.35) controlPoint2:CGPointMake(0, 12.46)];
        [shape addCurveToPoint:CGPointMake(4.79, 19.94) controlPoint1:CGPointMake(0, 17.83) controlPoint2:CGPointMake(2.11, 19.94)];
        [shape addCurveToPoint:CGPointMake(9.58, 15.15) controlPoint1:CGPointMake(7.48, 19.94) controlPoint2:CGPointMake(9.58, 17.83)];
        [shape addCurveToPoint:CGPointMake(4.79, 10.35) controlPoint1:CGPointMake(9.58, 12.46) controlPoint2:CGPointMake(7.48, 10.35)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(4.79, 18.5)];
        [shape addCurveToPoint:CGPointMake(1.44, 15.15) controlPoint1:CGPointMake(2.97, 18.5) controlPoint2:CGPointMake(1.44, 16.97)];
        [shape addCurveToPoint:CGPointMake(4.79, 11.79) controlPoint1:CGPointMake(1.44, 13.33) controlPoint2:CGPointMake(2.97, 11.79)];
        [shape addCurveToPoint:CGPointMake(8.15, 15.15) controlPoint1:CGPointMake(6.61, 11.79) controlPoint2:CGPointMake(8.15, 13.33)];
        [shape addCurveToPoint:CGPointMake(4.79, 18.5) controlPoint1:CGPointMake(8.15, 16.97) controlPoint2:CGPointMake(6.61, 18.5)];
        [shape closePath];
        [shape moveToPoint:CGPointMake(4.79, 18.5)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, 0.03);
        [[UIColor colorWithHue:0.118 saturation:0.751 brightness:0.929 alpha:1] setFill];
        [shape fill];
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
    }
    
    CGContextRestoreGState(context);
}


#pragma mark - Canvas Images

//! Page 1

+ (UIImage *)imageOfInfoFilled {
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(11, 25), NO, 0);
    [Icons drawInfoFilled];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageOfMapFilled {
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(15, 25), NO, 0);
    [Icons drawMapFilled];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageOfSubFilled {
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(20, 25), NO, 0);
    [Icons drawSubFilled];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageOfBusFilled {
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(34, 25), NO, 0);
    [Icons drawBusFilled];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageOfBicycleFilled {
    static UIImage * image = nil;
    if (image != nil)
        return image;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(25, 25), NO, 0);
    [Icons drawBicycleFilled];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - Resizing Behavior

CGRect IconsResizingBehaviorApply(IconsResizingBehavior behavior, CGRect rect, CGRect target) {
    if (CGRectEqualToRect(rect, target) || CGRectEqualToRect(target, CGRectZero)) {
        return rect;
    }
    
    CGSize scales = CGSizeZero;
    scales.width = ABS(target.size.width / rect.size.width);
    scales.height = ABS(target.size.height / rect.size.height);
    
    switch (behavior) {
        case IconsResizingBehaviorAspectFit: {
            scales.width = MIN(scales.width, scales.height);
            scales.height = scales.width;
            break;
        }
        case IconsResizingBehaviorAspectFill: {
            scales.width = MAX(scales.width, scales.height);
            scales.height = scales.width;
            break;
        }
        case IconsResizingBehaviorStretch:
            break;
        
        case IconsResizingBehaviorCenter: {
            scales.width = 1;
            scales.height = 1;
            break;
        }
    }
    
    CGRect result = CGRectStandardize(rect);
    result.size.width *= scales.width;
    result.size.height *= scales.height;
    result.origin.x = target.origin.x + (target.size.width - result.size.width) / 2;
    result.origin.y = target.origin.y + (target.size.height - result.size.height) / 2;
    return result;
}


@end
