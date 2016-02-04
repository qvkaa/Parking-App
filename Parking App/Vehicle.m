//
//  Vehicle.m
//  Parking App
//
//  Created by Yavor Aleksiev on 1/25/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "Vehicle.h"

static NSInteger totalParkedVehicles = 0;

@implementation Vehicle

- (instancetype)initWithPlateLicense:(NSString *)plate
                              color:(NSString *)color
                        manufacturer:(NSString *)manufacturer
                               model:(NSString *)model
                                year:(NSNumber *)year {
    self = [super init];
    if (self) {
        _plateLicenseNumber = plate;
        _manufacturer = manufacturer;
        _model = model;
        _yearOfManufacture = year;
        _color = color;
        totalParkedVehicles++;
    }
    return self;
}
+ (NSInteger)totalParkedVehicles {
    return totalParkedVehicles;
}

- (NSString *)vehicleInfo {
    return [NSString stringWithFormat:
            @"Plate # :%@"
            "\nColor : %@"
            "\nManufacturer : %@"
            "\nModel : %@"
            "\nYear : %@",
            self.plateLicenseNumber,
            self.color,
            self.manufacturer,
            self.model,
            self.yearOfManufacture];
}
@end
