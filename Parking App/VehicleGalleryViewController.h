//
//  VehicleGalleryViewController.h
//  Parking App
//
//  Created by yavoraleksiev on 2/29/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicleGalleryScrollView.h"


@interface VehicleGalleryViewController : UIViewController <VehicleGalleryScrollViewDelegate,VehicleGalleryScrollViewDataSource,UIScrollViewDelegate,UIViewControllerTransitioningDelegate>
@property (strong, nonatomic) IBOutlet VehicleGalleryScrollView *galleryScrollView;
@property (nonatomic) NSInteger tableViewRow;
@property (nonatomic) CGRect originFrame;
@end
