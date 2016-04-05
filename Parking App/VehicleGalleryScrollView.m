//
//  VehicleGalleryScrollView.m
//  Parking App
//
//  Created by yavoraleksiev on 2/29/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "VehicleGalleryScrollView.h"

@interface VehicleGalleryScrollView()

@property (strong,nonatomic,readonly) NSMutableSet *reusableGalleryCells; //of GalleryCell
@property (strong,nonatomic) NSMutableArray *visibleCells; //of GalleryCell
@property (strong,nonatomic) UIView *galleryContainerView;
@property (nonatomic) NSInteger collumIndex;
@property (nonatomic) NSInteger totalCells;
@property (nonatomic) BOOL isContentSizeSet;
@property (nonatomic) CGFloat hiddenOffset; //due to recentering
@property (nonatomic) BOOL scrollViewCenterDetermined;
@property (nonatomic) CGPoint scrollViewCenter;
@property (nonatomic) CGFloat currentLocationInSuperView;
@property (nonatomic) BOOL animationBegan;
@property (nonatomic) CGFloat startingLocationInSuperView;
@property (nonatomic) CGFloat panDistanceThreshold;
@property (nonatomic) BOOL lockScrollingDirection;
@property (nonatomic) BOOL horisontalScrollingLocked;
@end

@implementation VehicleGalleryScrollView
@synthesize reusableGalleryCells = _reusableGalleryCells;

#pragma mark - lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _isContentSizeSet = NO;
        _collumIndex = -1;
        _scrollViewCenterDetermined = NO;
        _hiddenOffset = 0.0f;
        _currentLocationInSuperView = 999.0f;
        _panDistanceThreshold = 99999.0f;
        _animationBegan = NO;
        _lockScrollingDirection = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = [UIColor clearColor];
        [self setPagingEnabled:YES];
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(respondToPanGesture:)];
        panRecognizer.delegate = self;
        panRecognizer.maximumNumberOfTouches = 1;

        [self addGestureRecognizer:panRecognizer];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _isContentSizeSet = NO;
        _collumIndex = -1;
        _scrollViewCenterDetermined = NO;
        _hiddenOffset = 0.0f;
        _currentLocationInSuperView = 999.0f;
        _panDistanceThreshold = 99999.0f;
        _animationBegan = NO;
        _lockScrollingDirection = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
        self.bounces = NO;
        [self setPagingEnabled:YES];
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(respondToPanGesture:)];
        panRecognizer.delegate = self;
        panRecognizer.maximumNumberOfTouches = 1;
        
        [self addGestureRecognizer:panRecognizer];
    }
    return self;
   
}

#pragma mark - accessors
- (NSMutableArray *)visibleCells {
    if (!_visibleCells) {
        _visibleCells = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return _visibleCells;
}
- (UIView *)galleryContainerView {
    if (!_galleryContainerView) {
        CGFloat height = self.contentSize.height;
        CGFloat width = self.contentSize.width;
        CGRect rect = CGRectMake(0, 0, width, height);
        _galleryContainerView = [[UIView alloc] initWithFrame:rect];
        _galleryContainerView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.galleryContainerView];
        
    }
    return _galleryContainerView;
}
#pragma mark - private

- (NSMutableSet *)reusableGalleryCells {
    if (!_reusableGalleryCells) {
        _reusableGalleryCells = [[NSMutableSet alloc] init];
    }
    return _reusableGalleryCells;
}

#pragma mark - public
- (void)setContainerViewAlphaTo:(CGFloat)alpha {
    self.galleryContainerView.alpha = alpha;
}
- (void)resetScrollView {
    self.collumIndex = -1;
    CGRect rect = self.bounds;
    rect.origin.x = 0.0;
    
    for (GalleryCell *lastCell in self.visibleCells) {
        [self.reusableGalleryCells addObject:lastCell];
    }
    self.visibleCells = nil;
    self.isContentSizeSet = NO;
    self.hiddenOffset = 0.0;
  
}
- (GalleryCell *)currentVisibleView {
    CGFloat cellWidth = self.frame.size.width;
    NSUInteger index = (NSInteger)floor(((self.contentOffset.x - self.hiddenOffset) * 2.0f + cellWidth) / (cellWidth * 2.0f));
    if (index == 0) {
        return [self.visibleCells objectAtIndex:0];
    } else {
        return [self.visibleCells objectAtIndex:1];
    }
}
- (void)changeContainerBackGroundColor:(UIColor *)color {
    self.galleryContainerView.backgroundColor = color;
    
}
- (GalleryCell *)dequeueReusableCell{
    GalleryCell *cell = [self.reusableGalleryCells anyObject];
    if (!cell){
        cell =  [[GalleryCell alloc] init];
        [self.galleryContainerView addSubview:cell];
        
    } else {
        [self.reusableGalleryCells removeObject:cell];
        [self.galleryContainerView addSubview:cell];
        
    }
    
    return cell;
}
- (GalleryCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    GalleryCell *cell = [self.reusableGalleryCells anyObject];
    if (!cell){
        
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] lastObject];
        if ([cell isKindOfClass:[GalleryCell class]]) {
            [self.galleryContainerView addSubview:cell];
        } else {
            cell =  [[GalleryCell alloc] init];
            [self.galleryContainerView addSubview:cell];
        }

    } else {
        [self.reusableGalleryCells removeObject:cell];
        [self.galleryContainerView addSubview:cell];

    }
    
    return cell;
}
#pragma mark - layout

- (void)recenterIfNecessary {
    CGFloat cellWidth = self.frame.size.width;
    CGPoint currentOffset = [self contentOffset];
    CGFloat centerOffsetX = (self.bounds.size.width);
    CGFloat distanceFromCenter = fabs(currentOffset.x - centerOffsetX) ;
    NSInteger cell = (NSInteger)floor(((self.contentOffset.x - self.hiddenOffset) * 2.0f + cellWidth) / (cellWidth * 2.0f));
    if (distanceFromCenter > (cellWidth / 2.0 )  && (cell != 0) && (cell != self.totalCells-1) ) {
        
        //determine if we need to shift left or right
        CGFloat offsetToCenter = cellWidth;
        if (currentOffset.x > centerOffsetX ) {
            offsetToCenter *= -1.0;
        }
        
        //shift the contennt offset
        CGPoint newPoint = CGPointMake(currentOffset.x + offsetToCenter, currentOffset.y);
        self.contentOffset = newPoint;
        //TODO: handle possible overflow of self.hiddenOffset
        
        //update the hidden offset
        self.hiddenOffset += offsetToCenter;
        
        //determine what cell we are on
        for (GalleryCell *cell in self.visibleCells) {
            CGRect newRect = cell.frame;
            newRect.origin.x += offsetToCenter;
            [cell setFrame:newRect];

            
       }
    }
}

- (void)checkIfVisibleRectIsInLimits:(CGRect)rect {

    CGFloat cellWidth = self.frame.size.width;
    CGFloat minimumLimit = cellWidth - 1;
    CGFloat maximumLimit = cellWidth + 1;
    NSInteger cell = (NSInteger)floor(((self.contentOffset.x - self.hiddenOffset) * 2.0f + cellWidth) / (cellWidth * 2.0f));
  
    if (cell <= 0 &&  rect.origin.x < minimumLimit) {
        rect.origin.x = cellWidth;
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{ [self scrollRectToVisible:rect animated:NO]; }
                         completion:NULL];
    }

    if (cell >= self.totalCells-1 && rect.origin.x > maximumLimit) {
        rect.origin.x = cellWidth;
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{ [self scrollRectToVisible:rect animated:NO]; }
                         completion:NULL];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.isContentSizeSet) {
            
        CGFloat offset = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        self.contentSize = CGSizeMake(offset*3,height );
        if ([self.galleryDelegate respondsToSelector:@selector(numberOfGalleryCells)]) {
            self.totalCells = [self.galleryDelegate numberOfGalleryCells];
        }
        self.isContentSizeSet = YES;
    }
    [self recenterIfNecessary];
    [self setTitle];
    CGRect visibleBounds = self.bounds;
    CGFloat minVisibleX = CGRectGetMinX(visibleBounds) - self.bounds.size.width ;
    CGFloat maxVisibleX = CGRectGetMaxX(visibleBounds) + self.bounds.size.width;
    [self tileCellsFromMinX:minVisibleX toMaxX:maxVisibleX];
    CGFloat cellWidth = self.frame.size.width;
    self.collumIndex = (NSInteger)floor(((self.contentOffset.x - self.hiddenOffset) * 2.0f + cellWidth) / (cellWidth * 2.0f));
}
- (void)setTitle {
    if ([self.galleryDelegate respondsToSelector:@selector(galleryScrollView:currentCellIndex:)]) {
        CGFloat cellWidth = self.frame.size.width;
        self.collumIndex = (NSInteger)floor(((self.contentOffset.x - self.hiddenOffset) * 2.0f + cellWidth) / (cellWidth * 2.0f));
        [self.galleryDelegate galleryScrollView:self currentCellIndex:self.collumIndex];
    }
}
- (CGFloat)placeCellOnRight:(CGFloat)rightEdge {

    CGFloat cellWidth = self.frame.size.width;
    self.collumIndex = (NSInteger)floor(((rightEdge - self.hiddenOffset) * 2.0f + cellWidth) / (cellWidth * 2.0f));
    GalleryCell *cell;
    if ([self.galleryDelegate respondsToSelector:@selector(galleryScrollView:cellForCollumAtIndex:)]) {
       cell = [self.galleryDelegate galleryScrollView:self cellForCollumAtIndex:self.collumIndex];
       
    }
    [self.visibleCells addObject:cell];
    CGRect frame = [cell frame];
    frame.origin.x = rightEdge;
    frame.origin.y = 0;
    frame.size.height = self.contentSize.height;
    frame.size.width = self.bounds.size.width;
    cell.frame = frame;
    return CGRectGetMaxX(frame);
}

- (CGFloat)placeCellOnLeft:(CGFloat)leftEdge {
    CGFloat cellWidth = self.frame.size.width ;
    CGFloat cellIndex = (NSInteger)floor(((leftEdge - self.hiddenOffset -(cellWidth/2.0)-1) * 2.0f + cellWidth) / (cellWidth * 2.0f));
    self.collumIndex = cellIndex;
    GalleryCell *cell = [self.galleryDelegate galleryScrollView:self cellForCollumAtIndex:self.collumIndex];
    [self.visibleCells insertObject:cell atIndex:0];
    CGRect frame = [cell frame];
    frame.origin.x = leftEdge - self.bounds.size.width;
    frame.origin.y = 0;
    frame.size.height = self.contentSize.height;
    frame.size.width = self.bounds.size.width;
    cell.frame = frame;
    return CGRectGetMinX(frame);
}
- (void)tileCellsFromMinX:(CGFloat)minX toMaxX:(CGFloat)maxX {
    CGFloat cellWidth = self.frame.size.width;
    NSInteger cell = (NSInteger)floor(((minX+cellWidth - self.hiddenOffset) * 2.0f + cellWidth) / (cellWidth * 2.0f));
    
    GalleryCell *firstCell;
    GalleryCell *lastCell;
    
    // make sure at least one cell is placed
    if ([self.visibleCells count] == 0 ) {
        [self placeCellOnRight:minX + self.bounds.size.width];
        
    }
    
    //add cells that are missing on the right side
    lastCell = [self.visibleCells lastObject];
    CGFloat rightEdge = CGRectGetMaxX([lastCell frame]);
    while ( (rightEdge + (cellWidth/2.0f)) < maxX && cell < self.totalCells - 1) {
        rightEdge = [self placeCellOnRight:rightEdge];
    }
    
    //add cells that are missing on the left side
    firstCell = [self.visibleCells objectAtIndex:0];
    CGFloat leftEdge = CGRectGetMinX([firstCell frame]);
    while ( (leftEdge - (cellWidth/2.0f)) > minX && cell > 0) {
        leftEdge = [self placeCellOnLeft:leftEdge];
    }
    
    //remove cells that have fallen off right edge
    lastCell = [self.visibleCells lastObject];
    while ( [lastCell frame].origin.x + cellWidth/2.0 > maxX) {
        [lastCell removeFromSuperview];
        [self.visibleCells removeLastObject];
        [self.reusableGalleryCells addObject:lastCell];
        lastCell = [self.visibleCells lastObject];
    }
    
    //remove cells that have fallen off left edge
    firstCell = [self.visibleCells objectAtIndex:0];
    while ((CGRectGetMaxX([firstCell frame]) - cellWidth / 2.0) < minX) {
        [firstCell removeFromSuperview];
        [self.visibleCells removeObjectAtIndex:0];
        [self.reusableGalleryCells addObject:firstCell];
        firstCell = [self.visibleCells objectAtIndex:0];
    }
}
- (void)centerToPreviousCell {
    CGFloat cellWidth = self.frame.size.width;
    
    NSInteger cell = (NSInteger)floor(((self.contentOffset.x - self.hiddenOffset) * 2.0f + cellWidth) / (cellWidth * 2.0f));
    CGRect rect = self.bounds;
    if (cell > 0 ) {
        rect.origin.x -= cellWidth;
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{ [self scrollRectToVisible:rect animated:NO]; }
                         completion:NULL];
    }
}
- (void)centerToNextCell {
    CGFloat cellWidth = self.frame.size.width;
    
    NSInteger cell = (NSInteger)floor(((self.contentOffset.x - self.hiddenOffset) * 2.0f + cellWidth) / (cellWidth * 2.0f));
    CGRect rect = self.bounds;
    if (cell < self.totalCells-1 ) {
        rect.origin.x += cellWidth;
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{ [self scrollRectToVisible:rect animated:NO]; }
                         completion:NULL];
    }
}

- (void)dismissScrollView {
    if ([self.galleryDelegate respondsToSelector:@selector(userDidTap)]) {
        if ([self.galleryDelegate respondsToSelector:@selector(swapProfileImageWithIndex:)]) {
            [self.galleryDelegate swapProfileImageWithIndex:self.collumIndex];
        }
        [self.galleryDelegate userDidTap];
    }
}

- (void)setSuperViewBackgroundAlphaTo:(CGFloat)alpha {
    
}
#pragma mark - pan gesture

- (void)respondToPanGesture:(UIPanGestureRecognizer *)recognizer {
    //dont handle more pan gestures if animation has began
    if (self.animationBegan) {
        return;
    }
    CGFloat distanceFromCenter = self.startingLocationInSuperView - self.currentLocationInSuperView;
    
    //determine the opacity of the view based on the distance from the center
    if (distanceFromCenter >= 0.0f) {
        CGFloat currentAlpha = distanceFromCenter / self.panDistanceThreshold;
        currentAlpha = 1.3f - currentAlpha;
        
        if (currentAlpha > 1.0f) {
            currentAlpha = 1.0f;
        } else if (currentAlpha < 0.0f) {
            currentAlpha = 0.0f;
        }
        self.galleryContainerView.alpha = currentAlpha;
        if ([self.galleryDelegate respondsToSelector:@selector(setBackgroundAlphaTo:)]) {
            [self.galleryDelegate setBackgroundAlphaTo:currentAlpha];
        }
    }
    
    // perform animation if the threshold is passed
    if (distanceFromCenter > self.panDistanceThreshold) {
        self.animationBegan = YES;
        [self dismissScrollView];
    } else {
        
        if (recognizer.state == UIGestureRecognizerStateChanged || recognizer.state == UIGestureRecognizerStateBegan) {
            
            //determine the start point of the pan gesture
            if (!self.scrollViewCenterDetermined) {
                self.scrollViewCenter = recognizer.view.center;
                self.scrollViewCenterDetermined = YES;
                self.startingLocationInSuperView = [recognizer locationInView:recognizer.view.superview].y;
                self.panDistanceThreshold = recognizer.view.frame.size.height / 4.0f;
            }
            
            CGFloat currentOffsetY = [recognizer translationInView:recognizer.view].y;
            CGFloat currentOffsetX = [recognizer translationInView:recognizer.view].x;
            
            // determine direction
            if (!self.lockScrollingDirection) {
                //determine if vertical scrolling
                if (currentOffsetY < -10.0f && (fabs(currentOffsetX) < 10.0f)) {
                    self.lockScrollingDirection = YES;
                    self.horisontalScrollingLocked = NO;
                    self.scrollEnabled = NO;
            
                    //horizontal scrolling takes priority
                } else if ( fabs(currentOffsetX) > 10.0f) {
                    self.lockScrollingDirection = YES;
                    self.horisontalScrollingLocked = YES;
                }
            }
            //if scrolling direction is locked Vertically calculate new location
            if (self.lockScrollingDirection && !self.horisontalScrollingLocked) {
                self.currentLocationInSuperView = [recognizer locationInView:recognizer.view.superview].y;
                CGPoint translation = [recognizer translationInView:recognizer.view];
                recognizer.view.center=CGPointMake(recognizer.view.center.x, recognizer.view.center.y+ translation.y);
                [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view];
                
            }
            
            // end of pan gesture reset all properites to inital state and return the view to its original center
        } else if (recognizer.state == UIGestureRecognizerStateEnded){
            self.lockScrollingDirection = NO;
            self.scrollEnabled = YES;
            self.scrollViewCenterDetermined = NO;
            self.currentLocationInSuperView = 999.0f;
            self.startingLocationInSuperView = 999.0f;
            [UIView animateWithDuration:0.3 animations:^{
                recognizer.view.center = self.scrollViewCenter;
                self.galleryContainerView.alpha = 1.0f;
                if ([self.galleryDelegate respondsToSelector:@selector(setBackgroundAlphaTo:)]) {
                    [self.galleryDelegate setBackgroundAlphaTo:1.0f];
                }
                
            }];
        }
    }

}
#pragma mark - gesture delegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
@end
