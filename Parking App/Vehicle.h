//
//  Vehicle.h
//  Parking App
//
//  Created by Yavor Aleksiev on 1/25/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject

@property NSString *plateLicenseNumber;
@property NSString *color;
@property NSString *manufacturer;
@property NSString *model;
@property NSNumber *yearOfManufacture;

- (instancetype)initWithPlateLicense:(NSString *)plate
                                 color:(NSString *)color
                           manufacturer:(NSString *)manufacturer
                                  model:(NSString *)model
                                   year:(NSNumber *)year;
+ (NSInteger)totalParkedVehicles;

- (NSString *)vehicleInfo;

@end
