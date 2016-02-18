//
//  ParkingLot.h
//  Parking App
//
//  Created by yavoraleksiev on 2/4/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vehicle.h"

@interface ParkingLot : NSObject

+ (id)defaultParking;

- (Vehicle *)vehicleAtIndex:(NSUInteger)index;

- (void)addVehicle:(Vehicle *)vehicle;

- (void)removeVehicleAtIndex:(NSUInteger)index;

- (NSUInteger)totalVehicles;

- (void)saveData;

- (void)loadData;

- (void)resetData;

- (NSString *)imageAtIndex:(NSUInteger)index;
@end
