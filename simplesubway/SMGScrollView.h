//
//  SMGScrollView.h
//  SubwaySimple
//
//  Created by Skye on 12/30/13.
//  Copyright (c) 2019 Skye. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SMGScrollViewDelegate;

@interface SMGScrollView : UIScrollView

@property (strong, nonatomic)   NSString*       imageName;
@property (strong, nonatomic)   NSString*       title;
@property (nonatomic)           NSInteger       index;
@property (nonatomic, weak)     id<SMGScrollViewDelegate> smgdelegate;

- (id)initWithTitle:(NSString*)title index:(NSInteger)index frame:(CGRect)frame imageName:(NSString*)imageName imageSize:(CGSize)imageSize;

@end

@protocol SMGScrollViewDelegate <NSObject>

@optional
- (void) scrollViewTapped:(SMGScrollView*)scrollView;
@end

