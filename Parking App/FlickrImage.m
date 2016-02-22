//
//  FlickrImage.m
//  Parking App
//
//  Created by yavoraleksiev on 2/19/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "FlickrImage.h"

@interface FlickrImage()

@property (strong,nonatomic,readwrite) NSString *imageID;
@property (strong,nonatomic,readwrite) NSString *farmID;
@property (strong,nonatomic,readwrite) NSString *server;
@property (strong,nonatomic,readwrite) NSString *secret;

@end

@implementation FlickrImage

#pragma mark - lifecycle
- (instancetype)initWithImageID:(NSString *)imageID farmID:(NSString *)farmID server:(NSString *)server secret:(NSString *)secret {
    self = [super init];
    if (self) {
        _imageID = imageID;
        _farmID = farmID;
        _server = server;
        _secret = secret;
    }
    return self;
}

#pragma mark - Class method
+ (NSString *)sizeTypeAtIndex:(NSUInteger)index {
    NSString *imageSize;
    switch (index) {
        case 0:
            imageSize = @"_s";
            break;
        case 1:
            imageSize = @"_m";
            break;
        case 2:
            imageSize = @"_t";
            break;
        case 3:
            imageSize = @"";
            break;
        default:
            break;
    }
    return imageSize;
 
}
#pragma mark - public methods
- (NSURL *)imageURL {
    return [self imageURLWithImageSize:ImageSizeDefault];
}
- (NSURL *)imageURLWithImageSize:(ImageSize)size {
    NSString *imageURL = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@%@.jpg",
                          self.farmID,
                          self.server,
                          self.imageID,
                          self.secret,
                          [FlickrImage sizeTypeAtIndex:size] ];
    return [NSURL URLWithString:imageURL];
}
#pragma mark - NSCoding required
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if ( self != nil )
    {
        //decode the properties
        self.imageID = [decoder decodeObjectForKey:@"imageID"];
        self.farmID = [decoder decodeObjectForKey:@"farmID"];
        self.server = [decoder decodeObjectForKey:@"server"];
        self.secret = [decoder decodeObjectForKey:@"secret"];
        
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode the properties of the object
    [encoder encodeObject:self.imageID forKey:@"imageID"];
    [encoder encodeObject:self.farmID forKey:@"farmID"];
    [encoder encodeObject:self.server forKey:@"server"];
    [encoder encodeObject:self.secret forKey:@"secret"];
}
@end
