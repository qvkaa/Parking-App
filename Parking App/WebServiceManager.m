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
//@property (strong, nonatomic) NSString *stringURL;
//@property (strong, nonatomic) NSURLSession *session;
//@property (strong, nonatomic) NSURLSessionDataTask *dataTask;

@end

@implementation WebServiceManager

//#pragma mark - Lifecycle
//
//+ (id)defaultWebServiceManager {
//    static WebServiceManager *sharedWebService = nil;
//    @synchronized (self) {
//        if (sharedWebService == nil)
//            sharedWebService = [[self alloc] init];
//    }
//    
//    return sharedWebService;
//}
//
//- (NSURLSession *)session {
//    if (!_session) {
//        _session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
//    }
//    
//    return _session;
//}
//#pragma mark - Public methods

- (void)fetchImageInfoForManufacturer:(NSString *)manufacturer model:(NSString *)model color:(NSString *)color  withCompletionBlock:(void (^)(NSArray *array))completionBlock {
//    NSString *urlString =[NSString stringWithFormat:
//                          @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&tag_mode=all&per_page=7&format=json&nojsoncallback=1",
//                          KEY, [NSString stringWithFormat:@"car,%@,%@,%@",
//                                manufacturer,
//                                model,
//                                color]];
//    NSURL *URL = [NSURL URLWithString:@"http://example.com/resources/123.json"];
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSLog(@"%@",urlString);
//    NSURLSessionDataTask *jsonData =
//    [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSError* errorr;
//        NSDictionary* json = [NSJSONSerialization
//                              JSONObjectWithData:data //1
//                              
//                              options:kNilOptions
//                              error: &errorr];
//        
//        NSDictionary *photos = [json objectForKey:@"photos"];
//        NSArray *array = [photos objectForKey:@"photo"];
//      //  NSString *imageURL;
//        if ([array count] > 0) {
//            
//            NSDictionary *photo = [[photos objectForKey:@"photo"] objectAtIndex:0];
//            
//            completionBlock(photo);
//
//        } else {
//            completionBlock(nil);
//            NSLog(@"no images found");
//       //     imageURL = @"";
//        }
//    }];
//
//    [jsonData resume];
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
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSLog(@"%@",urlString);
   
     [[AFHTTPSessionManager manager] GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {

         
                 NSDictionary *photos = [responseObject objectForKey:@"photos"];
                 NSArray *array = [photos objectForKey:@"photo"];

                 if ([array count] > 0) {
         
//                     NSDictionary *photo = [[photos objectForKey:@"photo"] objectAtIndex:0];
         
                     completionBlock(array);
         
                 } else {
                     completionBlock(nil);
                 }
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         completionBlock(nil);
     }];
    
                          
    }


@end
