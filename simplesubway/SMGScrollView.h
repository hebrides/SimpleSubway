//
//  SMGScrollView.h
//  SubwaySimple
//
//  Created by Bolt Action on 12/30/13.
//  Copyright (c) 2017 Bolt Action. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMGScrollView : UIScrollView

@property (strong, nonatomic)   NSString*       imageName;
@property (strong, nonatomic)   NSString*       title;
@property (nonatomic)           NSInteger       index;

- (id)initWithTitle:(NSString*)title index:(NSInteger)index frame:(CGRect)frame imageName:(NSString*)imageName imageSize:(CGSize)imageSize;

@end
