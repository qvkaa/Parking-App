//
//  Vehicle.m
//  Parking App
//
//  Created by Yavor Aleksiev on 1/25/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "Vehicle.h"

static NSInteger totalParkedVehicles = 0;

@interface Vehicle()

@property (strong,nonatomic,readwrite) NSString *manufacturer;
@property (strong,nonatomic,readwrite) NSString *model;
@property (strong,nonatomic,readwrite) NSNumber *yearOfManufacture;
//@property (strong,nonatomic,readwrite)NSString *imageURL;
//@property (strong,nonatomic,readwrite)FlickrImage *flickrImage;
@property (strong,nonatomic,readwrite) NSMutableArray *flickrImages; //of FlickrImage

@end

@implementation Vehicle

#pragma mark - lifecycle
-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if ( self != nil )
    {
        //decode the properties
        self.plateLicenseNumber = [decoder decodeObjectForKey:@"plate"];
        self.color = [decoder decodeObjectForKey:@"color"];
        self.manufacturer = [decoder decodeObjectForKey:@"manufacturer"];
        self.model = [decoder decodeObjectForKey:@"model"];
        self.yearOfManufacture = [decoder decodeObjectForKey:@"year"];
        self.flickrImages = [decoder decodeObjectForKey:@"flickr"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode the properties of the object
    [encoder encodeObject:self.plateLicenseNumber forKey:@"plate"];
    [encoder encodeObject:self.color forKey:@"color"];
    [encoder encodeObject:self.manufacturer forKey:@"manufacturer"];
    [encoder encodeObject:self.model forKey:@"model"];
    [encoder encodeObject:self.yearOfManufacture forKey:@"year"];
    [encoder encodeObject:self.flickrImages forKey:@"flickr"];
}


- (instancetype)init {
    self = [super init];
    if (self) {
        _plateLicenseNumber = @"";
        _color = @"";
        _manufacturer = @"";
        _model = @"";
        _yearOfManufacture = @0;
        _flickrImages = nil;
    }
    
    return self;
}
- (instancetype)initWithPlateLicense:(NSString *)plate
                              color:(NSString *)color
                        manufacturer:(NSString *)manufacturer
                               model:(NSString *)model
                                year:(NSNumber *)year
                               images:(NSMutableArray *)images {
    self = [super init];
    if (self) {
        _plateLicenseNumber = plate;
        _manufacturer = manufacturer;
        _model = model;
        _yearOfManufacture = year;
        _color = color;
        _flickrImages = images;
        totalParkedVehicles++;
    }
    return self;
}
#pragma mark - class methods
+ (NSInteger)totalParkedVehicles {
    return totalParkedVehicles;
}

#pragma mark - public methods
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
