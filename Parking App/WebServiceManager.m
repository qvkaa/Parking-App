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

@property (strong, nonatomic) NSString *stringURL;
@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSURLSessionDataTask *dataTask;

@end

@implementation WebServiceManager

#pragma mark - Lifecycle

+ (id)defaultWebServiceManager {
    static WebServiceManager *sharedWebService = nil;
    @synchronized (self) {
        if (sharedWebService == nil)
            sharedWebService = [[self alloc] init];
    }
    return sharedWebService;
}

- (NSURLSession *)session {
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    
    return _session;
}

- (void)getInfoFromTextFields {
    
//    NSLog(@"%@",[NSString stringWithFormat:@"%@+%@+%@",
//                 self.manufacturerTextField.text,
//                 self.modelTextField.text,
//                 self.colorTextField.text ]);
//    NSString *urlString =[NSString stringWithFormat:
//                          @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&tag_mode=all&per_page=1&format=json&nojsoncallback=1",
//                          KEY, [NSString stringWithFormat:@"car,%@,%@,%@",
//                                self.manufacturerTextField.text,
//                                self.modelTextField.text,
//                                self.colorTextField.text ]];
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
//        NSString *imageURL;
//        if ([array count] > 0) {
//            
//            NSDictionary *photo = [[photos objectForKey:@"photo"] objectAtIndex:0];
//            NSString *farmID = [photo objectForKey:@"farm"];
//            NSString *id = [photo objectForKey:@"id"];
//            NSString *server = [photo objectForKey:@"server"];
//            NSString *secret = [photo objectForKey:@"secret"];
//            
//            imageURL = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_t.jpg", farmID, server, id, secret];
//            NSLog(@"%@",imageURL);
//        } else {
//            NSLog(@"no images found");
//            imageURL = @"";
//        }
//        Vehicle* v = [[Vehicle alloc] initWithPlateLicense:self.licenseTextField.text
//                                                     color:self.colorTextField.text
//                                              manufacturer:self.manufacturerTextField.text
//                                                     model:self.modelTextField.text
//                                                      year:@([self.yearTextField.text integerValue])
//                                                     image:nil];
//        NSLog(@"%@",imageURL);
//        ParkingLot *parking = [ParkingLot defaultParking];
//        [parking addVehicle:v];
//        [parking saveData];
//    }];
//    
//    [jsonData resume];
    
}


- (void)fetchImageInfoForManufacturer:(NSString *)manufacturer model:(NSString *)model color:(NSString *)color withCompletionBlock:(void (^)(NSDictionary *photo))completionBlock {
    NSString *urlString =[NSString stringWithFormat:
                          @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&tag_mode=all&per_page=1&format=json&nojsoncallback=1",
                          KEY, [NSString stringWithFormat:@"car,%@,%@,%@",
                                manufacturer,
                                model,
                                color]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
    NSLog(@"%@",urlString);
    NSURLSessionDataTask *jsonData =
    [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError* errorr;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:data //1
                              
                              options:kNilOptions
                              error: &errorr];
        
        NSDictionary *photos = [json objectForKey:@"photos"];
        NSArray *array = [photos objectForKey:@"photo"];
        NSString *imageURL;
        if ([array count] > 0) {
            
            NSDictionary *photo = [[photos objectForKey:@"photo"] objectAtIndex:0];
            
            completionBlock(photo);

        } else {
            NSLog(@"no images found");
            imageURL = @"";
        }
    }];
    
    [jsonData resume];
}

@end
