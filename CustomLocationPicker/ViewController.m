//
//  ViewController.m
//  CustomLocationPicker
//
//  Created by Krishana on 5/9/17.
//  Copyright © 2017 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "CustomLocationPickerVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)selectAddressAction:(id)sender {
    [self performSegueWithIdentifier:@"VIEW_TO_ADDRESS_PICKER" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue destinationViewController] isKindOfClass:[CustomLocationPickerVC class]]) {
        CustomLocationPickerVC *vc = (CustomLocationPickerVC *)[segue destinationViewController];
        vc.lat = [NSString stringWithFormat:@"%f", CURRENT_LATITUDE] ? [NSString stringWithFormat:@"%f", CURRENT_LATITUDE] : @"";
        vc.lng = [NSString stringWithFormat:@"%f", CURRENT_LONGITUDE] ? [NSString stringWithFormat:@"%f", CURRENT_LONGITUDE] : @"";
        vc.address = CURRENT_ADDRESS ? CURRENT_ADDRESS : @"";
    }
}

- (IBAction)unwindFromLocationPickerToCreateOrder:(UIStoryboardSegue *)segue {
    if ([[segue sourceViewController] isKindOfClass:[CustomLocationPickerVC class]]) {
        //        ProfileCell *cell = (ProfileCell*)[self.registerTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        CustomLocationPickerVC *vc = (CustomLocationPickerVC *)[segue sourceViewController];
        self.labelLat.text = [NSString stringWithFormat:@"LAT - %@", vc.lat];
        self.labelLng.text = [NSString stringWithFormat:@"LNG - %@", vc.lng];
        self.labelFormattedAddress.text = [NSString stringWithFormat:@"ADDRESS - %@", vc.address];
        self.labelAddressName.text = [NSString stringWithFormat:@"CITY - %@, COUNTRY - %@", vc.city, vc.country];
    }
}

@end
