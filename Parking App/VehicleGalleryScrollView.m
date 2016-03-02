//
//  VehicleGalleryScrollView.m
//  Parking App
//
//  Created by yavoraleksiev on 2/29/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "VehicleGalleryScrollView.h"

@interface VehicleGalleryScrollView()
@property (strong,nonatomic,readonly) NSSet *reusableGalleryCells; //of GalleryCell
@property (strong,nonatomic) GalleryCell *cell;
@property (strong,nonatomic) NSMutableArray *visibileCells;
@property (strong,nonatomic) UIView *galleryContainerView;


@end

@implementation VehicleGalleryScrollView
@synthesize reusableGalleryCells = _reusableGalleryCells;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - lifecycle
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    CGSize size;
//    {
//        if (self) {
//            size = self.bounds.size;
//            self.contentSize = size;
//        }
//    }
//    return self;
//}
//- (void)awakeFromNib {
//    CGSize size;
//   
//            size = self.bounds.size;
//            self.contentSize = size;
//    [self setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
//  
//}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    CGFloat contentWidth = self.superview.bounds.size.width * 5;
    CGFloat contentHeight = self.bounds.size.height;
   self = [super initWithCoder:aDecoder];
    if (self) {
       // self.contentSize = CGSizeMake(5000, 500);
        [self setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        [self setBackgroundColor:[UIColor blackColor]];
        CGFloat contentWidth = self.bounds.size.width * 5;
        CGFloat contentHeight = self.bounds.size.height;
        self.contentSize = CGSizeMake(contentWidth, contentHeight);
       
    }
    return self;
}
#pragma mark - accessors
- (NSMutableArray *)visibileCells {
    if (!_visibileCells) {
        _visibileCells = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return _visibileCells;
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

- (NSSet *)reusableGalleryCells {
    if (!_reusableGalleryCells) {
        _reusableGalleryCells = [[NSSet alloc] init];
    }
    return _reusableGalleryCells;
}

#pragma mark - public
- (GalleryCell *)dequeueReusableCell {
    GalleryCell *cell = [self.reusableGalleryCells anyObject];
    
    if (!cell){
        
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
        //change cells
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //[self recenterIfNecessary];

//    CGRect visibleBounds = self.bounds;
//    CGFloat minVisibleX = CGRectGetMinX(visibleBounds);
//    CGFloat maxVisibleX = CGRectGetMaxX(visibleBounds);
//    [self tileCellsFromMinX:minVisibleX toMaxX:maxVisibleX];
    CGFloat cellX = 0;
    CGFloat offset = self.bounds.size.width;
    CGFloat max = self.galleryContainerView.bounds.size.width - offset;
    CGRect rect = CGRectMake(0, 0, offset, self.contentSize.height);
    while (cellX <= max) {
        GalleryCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"GalleryCell" owner:nil options:nil] lastObject];
        if ([cell isKindOfClass:[GalleryCell class]]) {
            rect.origin.x = cellX;
            cell.frame = rect;
            [self.galleryContainerView addSubview:cell];
            
            //[self.galleryContainerView setFrame:rect];
         //   cell.galleryImage.image = [UIImage imageNamed:@"defaultCar"];
        }
        cellX += offset;
    }
}

- (void)tileCellsFromMinX:(CGFloat)minX toMaxX:(CGFloat)maxX {
    CGFloat offset = self.bounds.size.width;
    CGFloat cellX = minX;
    
    while (cellX  < maxX) {
        GalleryCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"GalleryCell" owner:nil options:nil] lastObject];
        if ([cell isKindOfClass:[GalleryCell class]]) {
            [self.galleryContainerView addSubview:cell];
            
            CGRect rect = CGRectMake(cellX, 0, self.bounds.size.width, self.bounds.size.height);
            [self.galleryContainerView setFrame:rect];
            cell.galleryImage.image = [UIImage imageNamed:@"defaultCar"];
        }
        cellX += offset;
    }

}
@end
