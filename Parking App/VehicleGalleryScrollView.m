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
@property (nonatomic) BOOL lastCellPlacedWasToTheRight;
@property (nonatomic) BOOL isContentSizeSet;

@end

@implementation VehicleGalleryScrollView
@synthesize reusableGalleryCells = _reusableGalleryCells;

#pragma mark - lifecycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _isContentSizeSet = NO;
        _collumIndex = -1;
        self.showsHorizontalScrollIndicator = NO;
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
- (GalleryCell *)dequeueReusableCell{
    GalleryCell *cell = [self.reusableGalleryCells anyObject];
    if (!cell){
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GalleryCell" owner:nil options:nil] lastObject];
        if ([cell isKindOfClass:[GalleryCell class]]) {
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
    CGPoint currentOffset = [self contentOffset];
    CGFloat contentWidth = [self contentSize].width;
    CGFloat centerOffsetX = (contentWidth - self.bounds.size.width) / 2.0 ;
    CGFloat distanceFromCenter = fabs(currentOffset.x - centerOffsetX);
    if (distanceFromCenter > (contentWidth / 4.0)) {
        self.contentOffset = CGPointMake(centerOffsetX, currentOffset.y);
        for (GalleryCell *cell in self.visibleCells) {
            CGPoint center = cell.center;
            center.x += (centerOffsetX - currentOffset.x);
            cell.center = center;
            
       }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.isContentSizeSet) {
        CGFloat offset = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        self.contentSize = CGSizeMake(offset*5,height );
        if ([self.galleryDelegate respondsToSelector:@selector(numberOfGalleryCells)]) {
            self.totalCells = [self.galleryDelegate numberOfGalleryCells];
            NSLog(@"total %ld",_totalCells);
            
        }
        self.isContentSizeSet = YES;
    }
    
    [self recenterIfNecessary];
    CGRect visibleBounds = self.bounds;
    CGFloat minVisibleX = CGRectGetMinX(visibleBounds);
    CGFloat maxVisibleX = CGRectGetMaxX(visibleBounds);
    [self tileCellsFromMinX:minVisibleX toMaxX:maxVisibleX];

}

- (CGFloat)placeCellOnRight:(CGFloat)rightEdge {
    if (self.lastCellPlacedWasToTheRight) {
        self.collumIndex++;
    } else {
        self.collumIndex += 2;
    }
    if (self.collumIndex >= self.totalCells ) {
    self.collumIndex -= self.totalCells;
    }else if (self.collumIndex < 0) {
        self.collumIndex += self.totalCells;
    }
    self.lastCellPlacedWasToTheRight = YES;
    NSLog(@"index right %ld",self.collumIndex);
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
    if (self.lastCellPlacedWasToTheRight) {
        self.collumIndex -= 2;
         NSLog(@"<< %ld",self.collumIndex);
    } else {
        self.collumIndex--;
         NSLog(@"< %ld",self.collumIndex);
    }
    self.lastCellPlacedWasToTheRight = NO;
    if (self.collumIndex >= self.totalCells ) {
        self.collumIndex -= self.totalCells;
    }else if (self.collumIndex < 0) {
        self.collumIndex += self.totalCells;
    }
    GalleryCell *cell = [self.galleryDelegate galleryScrollView:self cellForCollumAtIndex:self.collumIndex]; // [self dequeueReusableCell];
    NSLog(@"index current %ld",self.collumIndex);
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
    GalleryCell *firstCell;
    GalleryCell *lastCell;
    // make sure at least one cell is placed
    if ([self.visibleCells count] == 0 ) {
        self.lastCellPlacedWasToTheRight = YES;
        [self placeCellOnRight:minX];
        
    }
    
    //add cells that are missing on the right side
    lastCell = [self.visibleCells lastObject];
    CGFloat rightEdge = CGRectGetMaxX([lastCell frame]);
    while (rightEdge < maxX) {
        rightEdge = [self placeCellOnRight:rightEdge];
    }
    
    //add cells that are missing on the left side
    firstCell = [self.visibleCells objectAtIndex:0];
    CGFloat leftEdge = CGRectGetMinX([firstCell frame]);
    while (leftEdge > minX) {
        leftEdge = [self placeCellOnLeft:leftEdge];
    }
    
    //remove cells that have fallen off right edge
    lastCell = [self.visibleCells lastObject];
    while ( [lastCell frame].origin.x > maxX) {
        [lastCell removeFromSuperview];
        [self.visibleCells removeLastObject];
        [self.reusableGalleryCells addObject:lastCell];
//        NSLog(@"right cell popped %ld",[self.reusableGalleryCells count]);
//        NSLog(@"self content offset %f",self.contentOffset.x);
        lastCell = [self.visibleCells lastObject];
    }
    
    //remove cells that have fallen off left edge
    firstCell = [self.visibleCells objectAtIndex:0];
    //NSLog(@"%f  < %f",CGRectGetMaxX([firstCell frame]) , minX);
    while (CGRectGetMaxX([firstCell frame]) < minX) {
        [firstCell removeFromSuperview];
        [self.visibleCells removeObjectAtIndex:0];
        [self.reusableGalleryCells addObject:firstCell];
//        NSLog(@"left cell popped %ld",[self.reusableGalleryCells count]);
//        NSLog(@"self content offset %f",self.contentOffset.x);
        firstCell = [self.visibleCells objectAtIndex:0];
    }
}
@end
