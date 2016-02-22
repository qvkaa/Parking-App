//
//  FlickrImage.h
//  Parking App
//
//  Created by yavoraleksiev on 2/19/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, ImageSize) {
    ImageSizeSmall       = 0 ,
    ImageSizeMedium    = 1 ,
    ImageSizeThumbnail   = 2 ,
    ImageSizeDefault = 3
};

 
@interface FlickrImage : NSObject  <NSCoding>

@property (strong,nonatomic,readonly) NSString *imageID;
@property (strong,nonatomic,readonly) NSString *farmID;
@property (strong,nonatomic,readonly) NSString *server;
@property (strong,nonatomic,readonly) NSString *secret;

- (instancetype)initWithImageID:(NSString *)imageID farmID:(NSString *)farmID server:(NSString *)server secret:(NSString *)secret;
- (NSURL *)imageURL;
- (NSURL *)imageURLWithImageSize:(ImageSize)size;

@end
