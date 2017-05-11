//
//  AppDelegate.m
//  CustomLocationPicker
//
//  Created by Krishana on 5/9/17.
//  Copyright © 2017 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [GMSPlacesClient provideAPIKey:GOOGLE_API_KEY];
    [GMSServices provideAPIKey:GOOGLE_API_KEY];
    [self getCurrentLocation];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)getCurrentLocation
{
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //NSLog(@"didUpdateToLocation: %@",[locations lastObject]);
    currentLocation = [locations lastObject];
    if (currentLocation != nil) {
        CURRENT_LATITUDE    =   currentLocation.coordinate.latitude;
        CURRENT_LONGITUDE   =   currentLocation.coordinate.longitude;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                       {
                           [self getAddressFromLocation:currentLocation];
                       });
    }
}

- (void) getAddressFromLocation: (CLLocation*) location {
    if (CURRENT_ADDRESS) {
        return;
    }
    //NSLog(@"getting address...");
    NSString *req = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&output=csv",[NSString stringWithFormat:@"%f",location.coordinate.latitude],[NSString stringWithFormat:@"%f",location.coordinate.longitude]];
    
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    
    if (result) {
        NSError *error;
        NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *resultArr = [dictResponse objectForKey:@"results"]; //objectForKey:@"geometry"];
        
        if(resultArr.count > 0) {
            NSDictionary *dict = [resultArr objectAtIndex:0];
            if ([dict objectForKey:@"formatted_address"]) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    CURRENT_ADDRESS = [dict objectForKey:@"formatted_address"];
                });
            }
        }
    }
}


@end
