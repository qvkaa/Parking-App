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
@property (nonatomic) NSUInteger currentCell;
@property (nonatomic) BOOL isContentSizeSet;

@end

@implementation GalleryScrollView

@synthesize reusableGalleryCells = _reusableGalleryCells;

#pragma mark - lifecycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
       
        [self setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        _currentCell = 0;
        
        _isContentSizeSet = NO;
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

- (NSMutableSet *)reusableGalleryCells {
    if (!_reusableGalleryCells) {
        _reusableGalleryCells = [[NSMutableSet alloc] init];
    }
    return _reusableGalleryCells;
}

#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.isContentSizeSet) {
        CGFloat offset = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        self.contentSize = CGSizeMake(offset*5,height );
        if ([self.galleryDelegate respondsToSelector:@selector(numberOfGalleryCellsForGalleryScrollView:)]) {
            self.cellCount = [self.galleryDelegate numberOfGalleryCellsForGalleryScrollView:self];
            NSLog(@"total %ld",self.cellCount);
            
        }
        self.isContentSizeSet = YES;
    }

}

@end
