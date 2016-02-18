//
//  ParkingLot.m
//  Parking App
//
//  Created by yavoraleksiev on 2/4/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "ParkingLot.h"

NSString * const VEHICLES = @"VEHICLES";

@interface ParkingLot()

@property (strong, nonatomic) NSMutableArray *vehicles;
@property (strong, nonatomic) NSMutableArray *vehiclePicURLS; //of NSString

@end

@implementation ParkingLot

//@synthesize defaults = _defaults;

#pragma mark - Lifecycle

+ (id)defaultParking {
    static ParkingLot *sharedParkingLot = nil;
    @synchronized (self) {
        if (sharedParkingLot == nil)
            sharedParkingLot = [[self alloc] init];
           }
    return sharedParkingLot;
}

//- (NSUserDefaults *)defaults {
//     _defaults = [NSUserDefaults standardUserDefaults];
//    return _defaults;
//}


//- (instancetype)init{
//    self = [super init];
//    
//    if (self) {
//       
//      
//        _vehicles = [[NSMutableArray alloc] init];
//    }
//    return self;
//}

#pragma mark - Add/Remove Vehicles

- (void)loadData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:VEHICLES];
    _vehicles = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
}
- (void)resetData {
    NSDictionary *defaultsDictionary = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    for (NSString *key in [defaultsDictionary allKeys]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)saveData {
    if (_vehicles) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:[NSArray arrayWithArray:self.vehicles]];
        [defaults setObject:dataSave forKey:VEHICLES];
        [defaults synchronize];
    }
}

#pragma mark - Accessor methods
- (NSMutableArray *)vehicles {
    if (!_vehicles) {
        _vehicles = [[NSMutableArray alloc] init];
    }
    
    return _vehicles;
}

- (void)addVehicle:(Vehicle *)vehicle {
    [self.vehicles addObject:vehicle];
}

- (void)removeVehicleAtIndex:(NSUInteger)index {
    [self.vehicles removeObjectAtIndex:index];
}
- (NSString *)imageAtIndex:(NSUInteger)index {
    NSUInteger size = [self.vehicles count];
    if (index < size) {
        return self.vehiclePicURLS[index];
    } else {
        return nil;
    }
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
