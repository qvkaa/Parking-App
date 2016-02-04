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

+ (id)sharedManager;

- (Vehicle *)vehicleAtIndex:(NSUInteger)index;

- (void)addVehicle:(Vehicle *)vehicle;

- (NSUInteger)totalVehicles;
@end
