//
//  EarthPhotoController.h
//  EarthImagesObjC
//
//  Created by Nick Reichard on 3/16/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class NLREarthPhoto;

@interface EarthPhotoController : NSObject

+ (void)fetchEarthPhotoInformationForLatitude:(NSString *)latitude longitude:(NSString *)longitude completion: (void (^)(NLREarthPhoto *earthPhoto))completion;

// We need a seperate function to grab the image
+ (void)fetchEarthPhotoWithURLString:(NSString *)urlString completion: (void (^)(UIImage *image))completion;

+ (NSString *)fetchAPIKeyFromPlist;

@end
