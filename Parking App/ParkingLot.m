//
//  ParkingLot.m
//  Parking App
//
//  Created by yavoraleksiev on 2/4/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "ParkingLot.h"

@interface ParkingLot()

@property (strong, nonatomic) NSMutableArray *vehicles;

@end

@implementation ParkingLot

+ (id)sharedManager {
    static ParkingLot *sharedParkingLot = nil;
    @synchronized (self) {
        if (sharedParkingLot == nil)
            sharedParkingLot = [[self alloc] init];
    }
    return sharedParkingLot;
}


- (instancetype)initWithArray:(NSMutableArray *) array {
    self = [super init];
    
    if (self) {
        
    }
    return self;
}
- (NSMutableArray *)vehicles {
    if (!_vehicles) {
        _vehicles = [[NSMutableArray alloc] init];
    }
    return _vehicles;
}

- (void)addVehicle:(Vehicle *)vehicle {
    [self.vehicles addObject:vehicle];
}
- (Vehicle *)vehicleAtIndex:(NSUInteger)index {
    NSUInteger size = [self.vehicles count];
    if (index < size) {
        return self.vehicles[index];
    } else {
        return nil;
    }
}

- (NSUInteger)totalVehicles {
    return [self.vehicles count];
}
@end
