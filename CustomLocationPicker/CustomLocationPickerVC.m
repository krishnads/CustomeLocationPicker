//
//  CustomLocationPickerVC.m
//  Cleanline
//
//  Created by Krishana on 4/25/17.
//  Copyright © 2017 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "CustomLocationPickerVC.h"

@interface CustomLocationPickerVC () {
    GMSPlace *selectedPlace;
}

@end

@implementation CustomLocationPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.city = @"";
    self.country = @"";
    
    // Do any additional setup after loading the view.
    self.title = @"SELECT ADDRESS";
    [CommonFunctions setRightBarButtonItemWithTitle:nil andBackGroundImage:[UIImage imageNamed:@"search"] andSelector:@selector(searchButtonAction) withTarget:self onController:self];
    
    [self.navigationController setNavigationBarHidden:NO];
    CLLocationCoordinate2D center;
    center.latitude = [self.lat doubleValue];
    center.longitude = [self.lng doubleValue];
    
    self.addressLabel.text = self.address;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[self.lat doubleValue]  longitude:[self.lng doubleValue] zoom:16];
    [_googleMapView setCamera:camera];
    _googleMapView.myLocationEnabled = YES;
    _googleMapView.delegate = self;
    //_googleMapView.padding = UIEdgeInsetsMake(0.0, 0.0, 0.0, 10.0);
    [self.viewAddressContainer.layer setCornerRadius:25.f];
    self.viewAddressContainer.layer.borderWidth = 1.f;
    self.viewAddressContainer.layer.borderColor = [UIColor colorWithRed:28.f/255.f green:181.f/255.f blue:234.f/255.f alpha:1.f].CGColor;
    [self.viewAddressContainer.layer masksToBounds];
}

- (void)searchButtonAction {
    selectedPlace = nil;
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
}

- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) mapView: (GMSMapView *)mapView didChangeCameraPosition: (GMSCameraPosition *)position {
    
    if (selectedPlace != nil) {
        selectedPlace = nil;
        return;
    }
    double latitude = mapView.camera.target.latitude;
    double longitude = mapView.camera.target.longitude;
    CLLocationCoordinate2D addressCoordinates = CLLocationCoordinate2DMake(latitude,longitude);
    GMSGeocoder* coder = [[GMSGeocoder alloc] init];
    [coder reverseGeocodeCoordinate:addressCoordinates completionHandler:^(GMSReverseGeocodeResponse *results, NSError *error) {
        if (error) {
            // NSLog(@"Error %@", error.description);
            self.country = @"";
            self.city = @"";
        } else {
            GMSAddress* address = [results firstResult];
            self.city = address.locality ? address.locality : @"";
            self.country = address.country ? address.country : @"";
            NSArray *arr = [address valueForKey:@"lines"];
            NSString *str1 = [NSString stringWithFormat:@"%lu",(unsigned long)[arr count]];
            if ([str1 isEqualToString:@"0"]) {
                self.addressLabel.text = @"";
            }
            else if ([str1 isEqualToString:@"1"]) {
                NSString *str2 = [arr objectAtIndex:0];
                self.addressLabel.text = str2;
            }
            else if ([str1 isEqualToString:@"2"]) {
                NSString *str2 = [arr objectAtIndex:0];
                NSString *str3 = [arr objectAtIndex:1];
                if (str2.length > 1 ) {
                    self.addressLabel.text = [NSString stringWithFormat:@"%@,%@",str2,str3];
                }
                else {
                    self.addressLabel.text = [NSString stringWithFormat:@"%@",str3];
                }
            }
        }
    }]; 
}

- (IBAction)setAddressButtonAction:(id)sender {
    if (self.addressLabel.text.length == 0) {
        return;
    }
    self.address = self.addressLabel.text;
    self.lat = [NSString stringWithFormat:@"%f", self.googleMapView.camera.target.latitude];
    self.lng = [NSString stringWithFormat:@"%f", self.googleMapView.camera.target.longitude];
    [self performSegueWithIdentifier:@"unwindFromLocationPickerView" sender:nil];
}

- (IBAction)locateCurrentLocation:(id)sender {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[self.lat doubleValue]  longitude:[self.lng doubleValue] zoom:16];
    [_googleMapView setCamera:camera];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    self.country = @"";
    self.city = @"";
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    selectedPlace = place;
    double latitude = place.coordinate.latitude;
    double longitude = place.coordinate.longitude;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude  longitude:longitude zoom:16];
    [_googleMapView setCamera:camera];
    self.addressLabel.text = place.formattedAddress;
    
    for (GMSAddressComponent *compCity in place.addressComponents) {
        if ([compCity.type isEqualToString:@"locality"]) {
            self.city = compCity.name ? compCity.name : @"";
        }
        else if ([compCity.type isEqualToString:@"country"]) {
            self.country = compCity.name ? compCity.name : @"";
        }
    }
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
