//
//  EarthPhotoController.m
//  EarthImagesObjC
//
//  Created by Nick Reichard on 3/16/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

#import "EarthPhotoController.h"
#import "NLREarthPhoto.h"

static NSString * const baseURLString = @"https://api.nasa.gov/planetary/earth/imagery";

@implementation EarthPhotoController

+(void)fetchEarthPhotoInformationForLatitude:(NSString *)latitude longitude:(NSString *)longitude completion:(void (^)(NLREarthPhoto *))completion
{
    if (!completion) { completion = ^(NLREarthPhoto *p) {}; }
    NSURL *baseURL = [[NSURL alloc] initWithString:baseURLString];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    // The way we want it to be formated. Like the datestyle in journal.style
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:[self fetchAPIKeyFromPlist]];
    NSURLQueryItem *latitudeItem = [NSURLQueryItem queryItemWithName:@"lat" value:latitude];
    NSURLQueryItem *longitudeItem = [NSURLQueryItem queryItemWithName:@"long" value:longitude];
    urlComponents.queryItems = @[apiKeyItem, latitudeItem, longitudeItem];
    // Puttting these items together into one
    
    NSURL *earthPhotoInformationEndpoint = urlComponents.URL;
    [[[NSURLSession sharedSession] dataTaskWithURL:earthPhotoInformationEndpoint completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error %@", error);
            completion(nil);
            return;
        }
        if (!data) {
            NSLog(@"Error no data returned from task");
            completion(nil);
            return;
        }
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (!jsonDictionary) {
            NSLog(@"Error: Could not serialize data");
            completion(nil);
            return;
        }
        // If the json is wrong we want to print an error. this protetcts us from the json
        NSString *errorString = jsonDictionary[@"error"];
        if (errorString) {
            NSLog(@"%@", errorString);
            completion(nil);
            return;
        }
        NLREarthPhoto *earthPhoto = [[NLREarthPhoto alloc] initWithDictionary:jsonDictionary];
        completion(earthPhoto);
    }]resume];
}

+(void)fetchEarthPhotoWithURLString:(NSString *)urlString completion:(void (^)(UIImage *))completion
{
    // Within NSURLSession, there are things called data tasks. Data tasks are a task for retriving the contents of a URL as an NSData object
    NSURL *imageURL = [NSURL URLWithString:urlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error){
            NSLog(@"Error %@", error);
            completion(nil);
            return;
        }
        if (!data){
            NSLog(@"Error no data returned from photo task");
            completion(nil);
            return;
        }
        UIImage *image = [[UIImage alloc]initWithData:data];
        completion(image);
        
    }]resume];
}

+(NSString *)fetchAPIKeyFromPlist
{
    // Get the url of the plist
    NSURL *apiKeyPlistURL = [[NSBundle mainBundle] URLForResource:@"APIKeys" withExtension:@"plist"];
    // Initialize a new object (usually a dictionary) from the contents of that url
    NSDictionary *apiKeys = [[NSDictionary alloc] initWithContentsOfURL:apiKeyPlistURL];
    // Parse through teh dictionary for the values you want
    NSString *apiKey = apiKeys[@"APIKey"];
    
    return apiKey;
}

@end
