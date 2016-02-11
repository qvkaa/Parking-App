//
//  ValidateDataUtil.h
//  Parking App
//
//  Created by Yavor Aleksiev on 1/27/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_OPTIONS(NSUInteger, ValidData) {
    ValidLicense        = 1 << 0,
    ValidColor          = 1 << 1,
    ValidManufacturer   = 1 << 2,
    ValidModel          = 1 << 3,
    ValidYear           = 1 << 4,
    ValidAll  = ValidLicense | ValidColor | ValidManufacturer | ValidModel | ValidYear
};

@interface ValidateDataUtil : NSObject

@property ValidData asd;
+ (ValidData)isValidYear:(NSString*) year;

+ (ValidData)isValidColor:(NSString *)color;

+ (ValidData)isValidLicense:(NSString*)word requiredLength:(NSUInteger)requiredLength;

+ (ValidData)isValidManufacturer:(NSString *)manufacturer;

+ (ValidData)isValidModel:(NSString *)model;

@end
