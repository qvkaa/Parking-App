//
//  VehicleGalleryScrollView.h
//  Parking App
//
//  Created by yavoraleksiev on 2/29/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryCell.h"
@class GalleryScrollView;
@protocol VehicleGalleryScrollViewDelegate <NSObject>



@end

@protocol VehicleGalleryScrollViewDataSource <NSObject>

- (NSInteger)galleryScrollView:(GalleryScrollView *)scrollView numberOfGalleryCell:(NSUInteger)section;

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (GalleryCell *)galleryScrollView:(GalleryScrollView *)scrollView cellForCollumAtIndex:(NSUInteger)index;

@end

@interface VehicleGalleryScrollView : UIScrollView



@property (weak, nonatomic) id<UIScrollViewDelegate,VehicleGalleryScrollViewDataSource,VehicleGalleryScrollViewDelegate> galleryDelegate;
@end


