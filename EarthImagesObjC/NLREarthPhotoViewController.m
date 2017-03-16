//
//  NLREarthPhotoViewController.m
//  EarthImagesObjC
//
//  Created by Nick Reichard on 3/16/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

#import "NLREarthPhotoViewController.h"
#import "EarthPhotoController.h"
#import "NLREarthPhoto.h"

@interface NLREarthPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *earthImageView;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *logitudeTextField;

@end

@implementation NLREarthPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)searchButtonTapped:(id)sender {
    // Running our big function
    [EarthPhotoController fetchEarthPhotoInformationForLatitude:self.latitudeTextField.text longitude:self.logitudeTextField.text completion:^(NLREarthPhoto *earthPhoto) {
        if (!earthPhoto) {NSLog(@"No earth photo Available"); }
        
        if (!earthPhoto.imageURL) {
            UIImage *noEarthPhotoImage = [UIImage imageNamed:@"NoImageFound"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.earthImageView
                .image = noEarthPhotoImage;
            });
            
        } else {
            [EarthPhotoController fetchEarthPhotoWithURLString:earthPhoto.imageURL completion:^(UIImage *image) {
                
                if (!image) { NSLog(@"No image returned for url"); return; }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.earthImageView.image = image;
                    self.longitudeLabel.text = earthPhoto.identifier;
                    self.latitudeLabel.text = earthPhoto.timestamp;
                });
                
            }];
        }
    }];
}





@end
