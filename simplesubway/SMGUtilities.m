//
//  SMGUtilities.m
//
//
//  Created by Bolt Action on 2/8/14.
//  Copyright (c) 2014 Bolt Action. All rights reserved.
//

#import "SMGUtilities.h"
#import "SMGAppDelegate.h"

@implementation SMGUtilities

+ imageWithName:(NSString *)imageName Size:(CGSize)size {
  CGRect rect = CGRectMake(0, 0, size.width, size.height);
  UIGraphicsBeginImageContext(size);
  [[UIImage imageNamed:imageName] drawInRect:rect]; //@"image.png"
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
//self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}
   
@end

@implementation UIImage(Overlay)
- (UIImage *)imageWithColor:(UIColor *)color1
{
  UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, 0, self.size.height);
  CGContextScaleCTM(context, 1.0, -1.0);
  CGContextSetBlendMode(context, kCGBlendModeNormal);
  CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
  CGContextClipToMask(context, rect, self.CGImage);
  [color1 setFill];
  CGContextFillRect(context, rect);
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}


@end
