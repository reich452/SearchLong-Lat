//
//  NLREarthPhoto.h
//  EarthImagesObjC
//
//  Created by Nick Reichard on 3/16/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLREarthPhoto : NSObject

-(instancetype)initWithImageURL:(NSString *)imageURL timestamp:(NSString *)timestamp identifier:(NSString *)identifier;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@property (nonatomic, copy)NSString *imageURL;
@property (nonatomic, copy)NSString *timestamp;
@property (nonatomic, copy)NSString *identifier;


@end
