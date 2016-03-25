//
//  VehicleGalleryScrollView.h
//  Parking App
//
//  Created by yavoraleksiev on 2/29/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryCell.h"
@class VehicleGalleryScrollView;
@protocol VehicleGalleryScrollViewDelegate <NSObject>



@end

@protocol VehicleGalleryScrollViewDataSource <NSObject>

- (NSInteger)numberOfGalleryCells;
- (GalleryCell *)galleryScrollView:(VehicleGalleryScrollView *)scrollView cellForCollumAtIndex:(NSUInteger)index;
@optional
- (void)galleryScrollView:(VehicleGalleryScrollView *)scrollView currentCellIndex:(NSInteger)index;
- (void)userDidTap;
- (void)swapProfileImageWithIndex:(NSUInteger)index;
@end

@interface VehicleGalleryScrollView : UIScrollView

@property (weak, nonatomic) id<UIScrollViewDelegate,VehicleGalleryScrollViewDataSource,VehicleGalleryScrollViewDelegate> galleryDelegate;
- (void)resetScrollView;
- (UIView *)currentVisibleView;
- (void)changeContainerBackGroundColor:(UIColor *)color;
- (GalleryCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (GalleryCell *)dequeueReusableCell;
- (void)centerToPreviousCell;
- (void)centerToNextCell;
@end


