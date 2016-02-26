//
//  VehicleListScrollView.m
//  Parking App
//
//  Created by yavoraleksiev on 2/26/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "VehicleListScrollView.h"

@interface VehicleListScrollView()

@end

@implementation VehicleListScrollView

#pragma mark - lifecycle

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.contentSize = CGSizeMake(5000, 500);
        [self setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    }
    return self;
}

#pragma mark - Layout

- (void)recenterIfNecessary {
    CGPoint currentOffset = [self contentOffset];
    CGFloat contentWidth = [self contentSize].width;
    
    //  5,000    - 500  = 4,500 /2  =  2,250
    CGFloat centerOffsetX = (contentWidth -  [self bounds].size.width) / 2.0;
    CGFloat distanceFromCenter = fabs(currentOffset.x - centerOffsetX);
    
    if (distanceFromCenter > (contentWidth/ 4.0)) {
        self.contentOffset = CGPointMake(centerOffsetX, currentOffset.y);
        // move content by same amount
    }
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self recenterIfNecessary];
    
    CGRect visibleBounds = [self bounds];
   
}
@end
