//
//  AppDelegate.h
//  CustomLocationPicker
//
//  Created by Krishana on 5/9/17.
//  Copyright © 2017 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

/**
 Reference to main window object
 */
@property (strong, nonatomic) UIWindow *window;

/**
 Used to get current loation of user
 */
- (void)getCurrentLocation;

/**
 used to get address from Location
 
 @param location CLLocation
 */
- (void) getAddressFromLocation: (CLLocation*) location;

@end

