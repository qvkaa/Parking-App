//
//  Vehicle.h
//  Parking App
//
//  Created by Yavor Aleksiev on 1/25/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject <NSCoding>

@property (strong,nonatomic)NSString *plateLicenseNumber;
@property (strong,nonatomic)NSString *color;
@property (strong,nonatomic,readonly)NSString *manufacturer;
@property (strong,nonatomic,readonly)NSString *model;
@property (strong,nonatomic,readonly)NSNumber *yearOfManufacture;

- (instancetype)initWithPlateLicense:(NSString *)plate
                                 color:(NSString *)color
                           manufacturer:(NSString *)manufacturer
                                  model:(NSString *)model
                                   year:(NSNumber *)year;
+ (NSInteger)totalParkedVehicles;

- (NSString *)vehicleInfo;



@end
