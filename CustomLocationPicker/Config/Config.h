//
//  Config.h
//  GarudaPassenger
//
//  Created by Krishana on 7/5/16.
//  Copyright © 2016 IK03. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define APPDELEGATE  ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define AppName @"Cleanline"

//DEMO Google api key for places api and maps
#define GOOGLE_API_KEY @"AIzaSyCE3qWJOtYAQM5x9erHRnRN1srNkBmi3xg"

//Macro for geocoding services
#define REVERSE_GEOCODE_ADDRESS_NOTIFICATION @"REVERSE_GEOCODE_ADDRESS_NOTIFICATION"
#define GEOCODE_ADDRESS_NOTIFICATION @"GEOCODE_ADDRESS_NOTIFICATION"
//App delegate macro
#define APP_DELEGATE  ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//Placeholder color
#define PLACEHOLDER_COLOR ([UIColor whiteColor])

//device checking macros
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define IS_HEIGHT_GTE_780 ([[UIScreen mainScreen ] bounds].size.height >= 780.0f)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define NAV_BAR_HEIGHT 64.0f

#define ApplicationThemePatternImage    [UIImage imageNamed:@"bg_pattern_image.png"]
#define ApplicationThemeColor           [UIColor colorWithRed:242/255.0f green:0/255.0f blue:48/255.0f alpha:1.0f]
#define TextFieldInputColor             [UIColor colorWithRed:1/255.0f green:86/255.0f blue:166/255.0f alpha:1.0f]


/**
 *  REGISTRATION_ERROR_DOMAIN define possible sub errors
 */
typedef enum
{
    RegistrationInvalidCountry,
    RegistrationInvalidPhone,
    RegistrationInvalidEmail,
    RegistrationInvalidPassword,
    RegistrationInvalidConfirmPassword,
    RegistrationUnknownError,
    RegistrationInvalidTerms
}RegistrationErrorDomain;

//Network Reachability Notification macro
#define NETWORK_REACHABILITY_NOTIFY @"NetworkReachableNotify"
#define NETWORK_UNREACHABILITY_NOTIFY @"NetworkUnReachableNotify"

//Rupee symbol macro
#define RUPEE_SYMBOL @"\u20B9"

//Reply message key from response
#define REPLY_KEY @"message"

@interface Config : NSObject

/**
 *  Reference to current latitude of user
 */
extern double CURRENT_LATITUDE;

/**
 *  Reference to current longitude of user
 */
extern double CURRENT_LONGITUDE;

/**
 *  Reference to current Address of user
 */
extern NSString *CURRENT_ADDRESS;

/**
 *  Reference to locationManager of CLLocationManager
 */
extern CLLocationManager *locationManager;

/**
 *  Reference to currentLocation of CLLocation
 */

extern  CLLocation  *currentLocation;


@end
