//
//  GalleryScrollView.h
//  Parking App
//
//  Created by yavoraleksiev on 3/8/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GalleryScrollView;
@protocol VehicleGalleryScrollViewDataSource <NSObject>

- (NSInteger)numberOfGalleryCellsForGalleryScrollView:(GalleryScrollView *)scrollView;

- (UIView *)galleryScrollView:(GalleryScrollView *)scrollView cellForCollumAtIndex:(NSUInteger)index;

@end
@interface GalleryScrollView : UIView

@end
