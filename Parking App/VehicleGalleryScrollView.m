//
//  VehicleGalleryScrollView.m
//  Parking App
//
//  Created by yavoraleksiev on 2/29/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "VehicleGalleryScrollView.h"

@implementation VehicleGalleryScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - lifecycle

- (instancetype)init {
   self = [super init];
    if (self) {
        self.contentSize = CGSizeMake(5000, 500);
        [self setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
    }
    return self;
}

#pragma mark - layout

- (void)recenterIfNecessary {
    CGPoint currentOffset = [self contentOffset];
    CGFloat contentWidth = [self contentSize].width;
    CGFloat centerOffsetX = (contentWidth - self.bounds.size.width) / 2.0 ;
    CGFloat distanceFromCenter = fabs(currentOffset.x - centerOffsetX);
    
    if (distanceFromCenter > (contentWidth / 4.0)) {
        self.contentOffset = CGPointMake(centerOffsetX, currentOffset.y);
    }
}

@end
