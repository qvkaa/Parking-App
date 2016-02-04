//
//  ValidateDataUtil.h
//  Parking App
//
//  Created by Yavor Aleksiev on 1/27/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateDataUtil : NSObject
+ (BOOL)isValidYear:(NSString*) year;
+ (BOOL)isValidLength:(NSString*)word requiredLength:(NSInteger*)requiredLength;
@end
