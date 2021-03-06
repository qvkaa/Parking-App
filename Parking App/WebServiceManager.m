//
//  WebServiceManager.m
//  Parking App
//
//  Created by yavoraleksiev on 2/22/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "WebServiceManager.h"


static const NSString *KEY = @"6672b42695aa8cfbcb8e7137a52ac235";
static const NSString *SECRET = @"0d150382efad5764";

@interface WebServiceManager()
@property (strong,nonatomic)AFImageDownloader *downloader;

@end

@implementation WebServiceManager

- (void)fetchImageInfoForManufacturer:(NSString *)manufacturer model:(NSString *)model color:(NSString *)color  withCompletionBlock:(void (^)(NSArray *array))completionBlock {
//    NSMutableString *tempManufacture = [manufacturer stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSMutableString *tempModel = [model stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSMutableString *tempColor = [color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    // 1
    NSMutableString *tags = [[NSMutableString alloc] init];
    [tags appendString:@"car"];
    if ( ![color isEqualToString:@""] ) {
        [tags appendString:[NSString stringWithFormat:@",%@",color]];
    }
    if ( ![manufacturer isEqualToString:@""] ) {
        [tags appendString:[NSString stringWithFormat:@",%@",manufacturer]];
    }
    if ( ![model isEqualToString:@""] ) {
        [tags appendString:[NSString stringWithFormat:@",%@",model]];
    }
    
    NSString *urlString =[NSString stringWithFormat:
                                                    @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&tag_mode=all&per_page=10&format=json&nojsoncallback=1",
                                                    KEY, tags];
    
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@","];

    NSURL *URL = [NSURL URLWithString:urlString];
   
     [[AFHTTPSessionManager manager] GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {

         
                 NSDictionary *photos = [responseObject objectForKey:@"photos"];
                 NSArray *array = [photos objectForKey:@"photo"];

                 if ([array count] > 0) {
                    completionBlock(array);
                 } else {
                     completionBlock(nil);
                 }
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         completionBlock(nil);
     }];
}

@end
