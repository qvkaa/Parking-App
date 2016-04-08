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
    NSMutableCharacterSet *validChars = [NSMutableCharacterSet alphanumericCharacterSet];
    NSMutableCharacterSet *charsInColor = [NSMutableCharacterSet characterSetWithCharactersInString:color];
    if (![validChars isSupersetOfSet:charsInColor]) {
        return 0;
    } else {
        return ValidColor;
    }
}



+ (ValidData)isValidModel:(NSString *)model {
    NSMutableCharacterSet *validChars = [NSMutableCharacterSet alphanumericCharacterSet];
    [validChars formUnionWithCharacterSet:[NSMutableCharacterSet whitespaceCharacterSet]];
    NSMutableCharacterSet *charsInModel = [NSMutableCharacterSet characterSetWithCharactersInString:model];
    if (![validChars isSupersetOfSet:charsInModel]) {
        return 0;
    } else {
        return ValidModel;
    }
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

    NSInteger number = [year integerValue];
    if( !(number > 1950 && number <= currentYear) ){
        isNumber = 0;
    }
    return isNumber;
    
}
+ (ValidData)isValidLicense:(NSString*)license requiredLength:(NSUInteger)requiredLength{
    NSUInteger currentLen =[license length];
    NSMutableCharacterSet *validChars = [NSMutableCharacterSet alphanumericCharacterSet];
    NSMutableCharacterSet *charsInLicense = [NSMutableCharacterSet characterSetWithCharactersInString:license];
//    [validChars formUnionWithCharacterSet:[NSMutableCharacterSet whitespaceCharacterSet]];
    if( currentLen != requiredLength || ![validChars isSupersetOfSet:charsInLicense]) {
        return 0;
    }else{
        return ValidLicense;
    }
}
+ (ValidData)isValidManufacturer:(NSString *)manufacturer {
    NSMutableCharacterSet *validChars = [NSMutableCharacterSet alphanumericCharacterSet];
    [validChars formUnionWithCharacterSet:[NSMutableCharacterSet whitespaceCharacterSet]];
    NSMutableCharacterSet *charsInManufacturer = [NSMutableCharacterSet characterSetWithCharactersInString:manufacturer];
    if (![validChars isSupersetOfSet:charsInManufacturer]) {
        return 0;
    } else {
        return ValidManufacturer;
    }
}

@end
