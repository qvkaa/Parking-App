//
//  WebServiceManager.h
//  Parking App
//
//  Created by yavoraleksiev on 2/22/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFImageDownloader.h"
@interface WebServiceManager : AFHTTPSessionManager

//+ (id)defaultWebServiceManager;

- (void)fetchImageInfoForManufacturer:(NSString *)manufacturer model:(NSString *)model color:(NSString *)color withCompletionBlock:(void (^)(NSArray *array))completionBlock;

@end
