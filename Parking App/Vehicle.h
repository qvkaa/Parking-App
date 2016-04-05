//
//  Vehicle.h
//  Parking App
//
//  Created by Yavor Aleksiev on 1/25/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrImage.h"

@interface Vehicle : NSObject <NSCoding>

@property (strong,nonatomic) NSString *plateLicenseNumber;
@property (strong,nonatomic) NSString *color;
@property (strong,nonatomic,readonly) NSString *manufacturer;
@property (strong,nonatomic,readonly) NSString *model;
@property (strong,nonatomic,readonly) NSNumber *yearOfManufacture;
@property (strong,nonatomic,readonly) NSMutableArray *flickrImages; //of FlickrImage
- (instancetype)initWithPlateLicense:(NSString *)plate
                               color:(NSString *)color
                        manufacturer:(NSString *)manufacturer
                               model:(NSString *)model
                                year:(NSNumber *)year
                               images:(NSMutableArray *)images;

+ (NSInteger)totalParkedVehicles;

- (NSString *)vehicleInfo;
- (void)swapVehicleAtIndex:(NSUInteger)index1 withIndex:(NSUInteger)index2;


@end
