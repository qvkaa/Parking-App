//
//  ValidateDataUtil.m
//  Parking App
//
//  Created by Yavor Aleksiev on 1/27/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "ValidateDataUtil.h"

@implementation ValidateDataUtil
+ (BOOL)isValidYear:(NSString*) year{
    //TODO get current year dynamically
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentYear = [components year];
    BOOL isNumber = YES;
    NSCharacterSet *numbers = [NSCharacterSet decimalDigitCharacterSet];
    
    NSCharacterSet *yearChars = [NSCharacterSet characterSetWithCharactersInString:year];
    
    if( ![numbers isSupersetOfSet:yearChars]){
        isNumber = NO;
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
        isNumber = NO;
    }
    return isNumber;
    
}
+ (BOOL)isValidLength:(NSString*)word requiredLength:(NSInteger)requiredLength{
    NSInteger currentLen =[word length];
    NSInteger reqLen = requiredLength;
    if( currentLen != reqLen) {
        return NO;
    }else{
        return YES;
    }
}
@end
