//
//  VehicleListViewController.h
//  Parking App
//
//  Created by Yavor Aleksiev on 1/28/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicleGalleryScrollView.h"
@interface VehicleListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,VehicleGalleryScrollViewDelegate,VehicleGalleryScrollViewDataSource,UIScrollViewDelegate>

@end
