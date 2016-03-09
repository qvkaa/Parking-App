//
//  VehicleGalleryViewController.m
//  Parking App
//
//  Created by yavoraleksiev on 2/29/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "VehicleGalleryViewController.h"
#import "ParkingLot.h"
#import "UIImageView+AFNetworking.h"

@interface VehicleGalleryViewController ()
@property (strong, nonatomic) IBOutlet VehicleGalleryScrollView *galleryScrollView;

@end

@implementation VehicleGalleryViewController
#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.galleryScrollView.galleryDelegate = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma mark - accessors

#pragma mark - delegate methods
- (CustomGalleryCell *)galleryScrollView:(VehicleGalleryScrollView *)scrollView cellForCollumAtIndex:(NSUInteger)index {
    ParkingLot *parking = [ParkingLot defaultParking];
    CustomGalleryCell *cell = [scrollView dequeueReusableCell];
    
    cell.galleryImage.image = [UIImage imageNamed:@"defaultCar"];
    NSInteger totalImages =  [[parking vehicleAtIndex:self.tableViewRow].flickrImages count];
    if ( totalImages < 1) { // no images for that vehicle
        return cell;
    }
    NSInteger cellIndex = index;
    while (cellIndex < 0) {
        cellIndex += totalImages;
    }
    cellIndex %= totalImages;
    
    if ([[[parking vehicleAtIndex:self.tableViewRow].flickrImages objectAtIndex:cellIndex] imageURL]) {
               NSURLRequest *request = [NSURLRequest requestWithURL:[[[parking vehicleAtIndex:self.tableViewRow].flickrImages objectAtIndex:cellIndex] imageURLWithImageSize:ImageSizeDefault]];
        [cell.galleryImage setImageWithURLRequest:request
                                   placeholderImage:nil
                                            success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                                cell.galleryImage.image = image;
                                                [cell.galleryImage setBackgroundColor:[UIColor blackColor]];
                                            }
                                            failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                                NSLog(@"%@",[error description]);
                                                cell.galleryImage.image = [UIImage imageNamed:@"defaultCar"];
                                            }];
    }
    return cell;

}

- (NSInteger)numberOfGalleryCells {
    ParkingLot *parking = [ParkingLot defaultParking];
    NSInteger totalImages =  [[parking vehicleAtIndex:self.tableViewRow].flickrImages count];
    return totalImages;
}
@end
