//
//  CustomTableViewCell.h
//  Parking App
//
//  Created by yavoraleksiev on 2/9/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *vehiclePicture;
@property (weak, nonatomic) IBOutlet UILabel *vehicleInfoLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *pictureLoadingIndicator;

//@property (weak, nonatomic) IBOutlet UILabel *customCellLabel;


@end
