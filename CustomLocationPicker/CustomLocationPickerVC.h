//
//  CustomLocationPickerVC.h
//  Cleanline
//
//  Created by Krishana on 4/25/17.
//  Copyright © 2017 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLocationPickerVC : UIViewController <GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate>

/**
 Reference to UILabel holds address
 */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

/**
 Reference to GMSMapView shows location on google map
 */
@property (weak, nonatomic) IBOutlet GMSMapView *googleMapView;

/**
 Reference to UIView shows address
 */
@property (weak, nonatomic) IBOutlet UIView *viewAddressContainer;

/**
 Reference to set address button
 */
@property (weak, nonatomic) IBOutlet UIButton *buttonSetAddress;

/**
 Reference to NSString holds address
 */
@property (strong, nonatomic) NSString *address;

/**
 Reference to NSString holds latitude
 */
@property (strong, nonatomic) NSString *lat;

/**
 Reference to NSString holds longitude
 */
@property (strong, nonatomic) NSString *lng;

/**
 Reference to NSString holds city
 */
@property (strong, nonatomic) NSString *city;

/**
 Reference to NSString holds country
 */
@property (strong, nonatomic) NSString *country;

/**
 Used to navigate back to previous screen
 */
- (void)backButtonAction;

/**
 Used to set selected address

 @param sender Set Address button
 */
- (IBAction)setAddressButtonAction:(id)sender;

/**
 Used to set current address
 
 @param sender GPS button
 */
- (IBAction)locateCurrentLocation:(id)sender;

@end
