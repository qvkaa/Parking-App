//
//  GalleryScrollView.m
//  Parking App
//
//  Created by yavoraleksiev on 3/8/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "GalleryScrollView.h"
@interface GalleryScrollView()

@property (strong,nonatomic,readonly) NSMutableSet *reusableGalleryCells; 
@property (strong,nonatomic) NSMutableArray *visibleCells;
@property (strong,nonatomic) UIView *galleryContainerView;
@property (nonatomic) NSUInteger cellCount;

@end

@implementation GalleryScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
