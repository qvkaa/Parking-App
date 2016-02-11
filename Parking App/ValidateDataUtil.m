//
//  ValidateDataUtil.m
//  Parking App
//
//  Created by Yavor Aleksiev on 1/27/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "ValidateDataUtil.h"

@implementation ValidateDataUtil

+ (ValidData)isValidColor:(NSString *)color {
    return ValidColor;
}


+ (ValidData)isValidManufacturer:(NSString *)manufacturer {
    return ValidManufacturer;
}

+ (ValidData)isValidModel:(NSString *)model {
    return ValidModel;
}
+ (ValidData)isValidYear:(NSString*) year{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentYear = [components year];
    NSUInteger isNumber = ValidYear;
    NSCharacterSet *numbers = [NSCharacterSet decimalDigitCharacterSet];
    
    NSCharacterSet *yearChars = [NSCharacterSet characterSetWithCharactersInString:year];
    
    if( ![numbers isSupersetOfSet:yearChars]){
        isNumber = 0;
    }
   /* for(int i = 0 ; i < year.length; ++i){
        char temp = [year characterAtIndex:i];
        if(temp < zero || temp > nine){ //   ascii
            isNumber = NO;
            break;
        }
    }*/
    //Check if year is in valid range  0 - current year
    NSInteger number = [year integerValue];
    if( !(number > 1950 && number <= currentYear) ){
        isNumber = 0;
    }
    return isNumber;
    
}
+ (ValidData)isValidLicense:(NSString*)license requiredLength:(NSUInteger)requiredLength{
    NSUInteger currentLen =[license length];
    
    if( currentLen != requiredLength) {
        return 0;
    }else{
        return ValidLicense;
    }
}

@end
