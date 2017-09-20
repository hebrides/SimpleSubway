#import "SMGScrollView.h"
#import "TilingView.h"
#import "SMGUtilities.h"
#import "SMGAppDelegate.h"

@interface SMGScrollView () <UIScrollViewDelegate>

@property (strong, nonatomic)   UIImageView*    imageView;
@property (strong, nonatomic)   TilingView*     tilingView;
@property (nonatomic)           CGSize          imageSize;
@property (nonatomic)           CGPoint         pointToCenterAfterResize;
@property (nonatomic)           CGFloat         scaleToRestoreAfterResize;
@end


//@synthesize
@implementation SMGScrollView

- (id)initWithTitle:(NSString*)title index:(NSInteger)index frame:(CGRect)frame imageName:(NSString*)imageName imageSize:(CGSize)imageSize
{
  self = [super initWithFrame:frame];
  if (self) {
    _title = title;
    _index = index;
    // Causes unpredicatable behavior
    //        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //        self.autoresizesSubviews = YES;
    self.showsVerticalScrollIndicator = YES;
    self.showsHorizontalScrollIndicator = YES;
    self.bouncesZoom = YES;
    self.decelerationRate = UIScrollViewDecelerationRateNormal;
    self.delegate = self;
    self.imageSize = imageSize;
    self.imageName = imageName;
    self.zoomScale = 1.0;
    self.backgroundColor = [UIColor clearColor];//VIEW_BACKGROUND_COLOR;
    self.hidden = true;
    
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:(CGRect){ CGPointZero, self.imageSize }];
    UIImage* placeHolderImage = [UIImage imageNamed: [NSString stringWithFormat:@"%@_Placeholder", self.imageName]];
    
    [self.imageView setImage: placeHolderImage];
    
    // Add tiling view
    self.tilingView = [[TilingView alloc] initWithImageName:self.imageName size:self.imageSize];
    self.tilingView.frame = self.imageView.bounds;
    [self.imageView addSubview:self.tilingView];
    
    // Add imageView
    [self addSubview:self.imageView];
    
    // Configure
    [self configureForImageSize: self.imageSize];
    
    // Gesture recognizers
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self addGestureRecognizer:twoFingerTapRecognizer];
    
    UITapGestureRecognizer *oneFingerTapRecognizer = [[UITapGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(scrollViewOneFingerTapped:)];
    oneFingerTapRecognizer.numberOfTapsRequired = 1;
    oneFingerTapRecognizer.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:oneFingerTapRecognizer];
    
  }
  return self;
}

- (void) viewWillAppear {
  
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGSize boundsSize = self.bounds.size;
  CGRect frameToCenter = self.imageView.frame;
  
  // center horizontally
  if (frameToCenter.size.width < boundsSize.width)
    frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
  else
    frameToCenter.origin.x = 0;
  
  // center vertically
  if (frameToCenter.size.height < boundsSize.height)
    frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
  else
    frameToCenter.origin.y = 0;
  
  self.imageView.frame = frameToCenter;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return self.imageView;
}

- (void)configureForImageSize:(CGSize)imageSize
{
  self.imageSize = imageSize;
  self.contentSize = imageSize;
  [self setMaxMinZoomScalesForCurrentBounds];
  //set initial zoom
  self.zoomScale = 1.0*self.minimumZoomScale; // 1.0 initial zoom scale
}

- (void)setMaxMinZoomScalesForCurrentBounds
{
  CGSize boundsSize = self.bounds.size;
  
  CGFloat xScale = boundsSize.width  / self.imageSize.width;
  CGFloat yScale = boundsSize.height / self.imageSize.height;
  
  BOOL imagePortrait = self.imageSize.height > self.imageSize.width;
  BOOL phonePortrait = boundsSize.height > boundsSize.width;
  CGFloat minScale = imagePortrait == phonePortrait ? xScale : MIN(xScale, yScale);
  
  CGFloat maxScale = 1.7 / [[UIScreen mainScreen] scale]; // 1.0 is default
  
  if (minScale > maxScale) {
    minScale = maxScale;
  }
  self.maximumZoomScale = maxScale;
  self.minimumZoomScale = minScale;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
  //Zoom in
  CGPoint pointInView = [recognizer locationInView:self.imageView];
  
  CGFloat newZoomScale = self.zoomScale * 1.5f;
  newZoomScale = MIN(newZoomScale, self.maximumZoomScale);
  
  CGSize scrollViewSize = self.bounds.size;
  CGFloat w = scrollViewSize.width / newZoomScale;
  CGFloat h = scrollViewSize.height / newZoomScale;
  CGFloat x = pointInView.x - (w / 2.0f);
  CGFloat y = pointInView.y - (h / 2.0f);
  CGRect rectToZoomTo = CGRectMake(x, y, w, h);
  
  [self zoomToRect:rectToZoomTo animated:YES];
  
}

- (void)scrollViewOneFingerTapped:(UITapGestureRecognizer*)recognizer {
#ifdef DEBUG
  NSLog(@"One finger Tapped");
#endif
  
  if ([[self smgdelegate] respondsToSelector:@selector(scrollViewTapped:)]) {
    [self.smgdelegate scrollViewTapped:self];

  }
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
  // Zoom out
  CGFloat newZoomScale = self.zoomScale / 1.5f;
  newZoomScale = MAX(newZoomScale, self.minimumZoomScale);
  [self setZoomScale:newZoomScale animated:YES];
  
}


#pragma mark - Rotation support (Not implemented)

- (void)setFrame:(CGRect)frame
{
  BOOL sizeChanging = !CGSizeEqualToSize(frame.size, self.frame.size);
  
  if (sizeChanging) {
    [self prepareToResize];
  }
  [super setFrame:frame];
  
  if (sizeChanging) {
    [self recoverFromResizing];
  }
}


- (void)prepareToResize
{
  CGPoint boundsCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
  self.pointToCenterAfterResize = [self convertPoint:boundsCenter toView:self.imageView];
  self.scaleToRestoreAfterResize = self.zoomScale;
  
  // If we're at the minimum zoom scale, preserve that by returning 0, which will be converted to the minimum
  // allowable scale when the scale is restored.
  if (self.scaleToRestoreAfterResize <= self.minimumZoomScale + FLT_EPSILON)
    self.scaleToRestoreAfterResize = 0;
}

- (void)recoverFromResizing
{
  [self setMaxMinZoomScalesForCurrentBounds];
  
  CGFloat maxZoomScale = MAX(self.minimumZoomScale, self.scaleToRestoreAfterResize);
  self.zoomScale = MIN(self.maximumZoomScale, maxZoomScale);
  
  CGPoint boundsCenter = [self convertPoint:self.pointToCenterAfterResize fromView:self.imageView];
  CGPoint offset = CGPointMake(boundsCenter.x - self.bounds.size.width / 2.0,
                               boundsCenter.y - self.bounds.size.height / 2.0);
  
  CGPoint maxOffset = [self maximumContentOffset];
  CGPoint minOffset = [self minimumContentOffset];
  
  CGFloat realMaxOffset = MIN(maxOffset.x, offset.x);
  offset.x = MAX(minOffset.x, realMaxOffset);
  
  realMaxOffset = MIN(maxOffset.y, offset.y);
  offset.y = MAX(minOffset.y, realMaxOffset);
  
  self.contentOffset = offset;
}

- (CGPoint)maximumContentOffset
{
  CGSize contentSize = self.contentSize;
  CGSize boundsSize = self.bounds.size;
  return CGPointMake(contentSize.width - boundsSize.width, contentSize.height - boundsSize.height);
}

- (CGPoint)minimumContentOffset
{
  return CGPointZero;
}


@end
