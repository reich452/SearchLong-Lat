//
//  NLREarthPhoto.m
//  EarthImagesObjC
//
//  Created by Nick Reichard on 3/16/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

#import "NLREarthPhoto.h"

@implementation NLREarthPhoto

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *urlString = dictionary[@"url"];
    NSString *timeStamp = dictionary[@"date"];
    NSString *identifier = dictionary[@"id"];
    
    return [self initWithImageURL:urlString timestamp:timeStamp identifier:identifier];
    
    // Like { return nil } // Obj-c not as smart so you have to tell it to return
    // Sift init are specail, so you dont need to return
}

-(instancetype)initWithImageURL:(NSString *)image timestamp:(NSString *)timestamp identifier:(NSString *)identifier
{
    self = [super init];                    // Chunk of clay
    if (self) {                             // on the table. if let self = self
        _imageURL = [image copy];           // we need the [name copy] so it does not change.
        _timestamp = [timestamp copy];      // value of the item at that location
        identifier = [identifier copy];
    }
    return self;
}

@end
