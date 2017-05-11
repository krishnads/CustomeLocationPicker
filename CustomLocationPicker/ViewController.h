//
//  ViewController.h
//  CustomLocationPicker
//
//  Created by Krishana on 5/9/17.
//  Copyright © 2017 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelLat;
@property (weak, nonatomic) IBOutlet UILabel *labelLng;
@property (weak, nonatomic) IBOutlet UILabel *labelAddressName;
@property (weak, nonatomic) IBOutlet UILabel *labelFormattedAddress;

- (IBAction)selectAddressAction:(id)sender;


@end

