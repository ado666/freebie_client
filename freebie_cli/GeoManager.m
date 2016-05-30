//
//  GeoManager.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 31/08/15.
//  Copyright (c) 2015 Boris Kuznetsov. All rights reserved.
//

#import "GeoManager.h"
#import "NetContoll.h"

#import "AppDelegate.h"
#import "ViewController.h"

@implementation GeoManager

CLLocationManager *locManager;
CLGeocoder *geocoder;
CLPlacemark *placemark;

- (id)init
{
    self = [super init]; //вызываем конструктор базового класса для
    
    // network
//    self.netControll = [[NetContoll alloc] init];
    
    
    // locations
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    
//    [self.locationManager requestAlwaysAuthorization];
//    
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    [appDelegate testMethod];
    

    
//    UIViewController *vc = [[[UIApplication sharedApplication] delegate] window].rootViewController;
//    while (vc.presentedViewController != nil){
//        vc = vc.presentedViewController;
//    }
//    UIViewController *currentViewController = vc;
//    UIViewController *vv = [ViewController delegate];
//    [currentViewController testMethod];
    
//    UIApplication *ui = [[appDelegate] UIApplication];
    
//    [[UIApplication sharedApplication] ]
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    ViewController *rootViewController = window.rootViewController;
//    [rootViewController testMethod];
    
//    ViewController *viewControll = [UIApplication ]
    
    return self; //и возвращать самого себя
}

- (void)start
{
//    [self.locationManager startMonitoringSignificantLocationChanges];
//    [self.locationManager startUpdatingLocation];
    [self .locationManager startMonitoringSignificantLocationChanges];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
//    return;
    CLLocation *current = locations[0];
//    NSLog(@"%.8f", current.coordinate.latitude);
    
    //    CLLocation *target = [[CLLocation alloc] initWithLatitude:55.757876 longitude:37.658470];
//    NSLog(@"update");
    [self.netControll updateLocation:current.coordinate.longitude :current.coordinate.latitude];
    
    if (current != nil) {
//        self.lon.text = [NSString stringWithFormat:@"%.8f", current.coordinate.longitude];
//        self.lat.text = [NSString stringWithFormat:@"%.8f", current.coordinate.latitude];
    }
    
    double *nearest = 100000000;
    int *nearest_id;
    NSString *nearest_key;
    //    NSLog(@"%@", self.all_offers);
    for (NSDictionary *offer in self.all_offers){
        //        NSLog(@"%@", offer);
        for (NSDictionary *address in [offer valueForKeyPath:@"addresses"]){
            double lat = [[address valueForKeyPath:@"lat"] doubleValue];
            double lng = [[address valueForKeyPath:@"lng"] doubleValue];
            
            CLLocation *target = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
            int dist    = [current distanceFromLocation: target];
            
            if (dist < nearest) {
                nearest = dist;
                nearest_key = address;
                nearest_id = [[address valueForKeyPath:@"id"] integerValue];
            };
        }
        
    }
//    if (nearest <= radius) {
//        if (!self.notif){
//            self.notif = TRUE;
//            [self showMessage];
//        }
//    }else{
//        self.notif = FALSE;
//    }
    
    //    int dist    = [current distanceFromLocation: target];
    
    
//    self.dist.text = [NSString stringWithFormat:@"%@ : %i", [nearest_key valueForKeyPath:@"name"], nearest];
    //    self.dist.text = [nearest_key valueForKeyPath:@"name"];
    //    self.shareModel = [LocationShareModel sharedModel];
    //    //If the timer still valid, return it (Will not run the code below)
    //    if (self.shareModel.timer) {
    //        return;
    //    }
    //
    //    self.shareModel.bgTask = [BackgroundTaskManager sharedBackgroundTaskManager];
    //    [self.shareModel.bgTask beginNewBackgroundTask];
    //
    //    //Restart the locationMaanger after 1 minute
    //    self.shareModel.timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self
    //                                                           selector:@selector(restartLocationUpdates)
    //                                                           userInfo:nil
    //                                                            repeats:NO];
    //
    //    //Will only stop the locationManager after 10 seconds, so that we can get some accurate locations
    //    //The location manager will only operate for 10 seconds to save battery
    //    NSTimer * delay10Seconds;
    //    delay10Seconds = [NSTimer scheduledTimerWithTimeInterval:10 target:self
    //                                                    selector:@selector(stopLocationDelayBy10Seconds)
    //                                                    userInfo:nil
    //                                                     repeats:NO];
    
    //    if (dist <= radius){
    //        if (!self.notif){
    //            [self showMessage];
    //            self.notif = true;
    //        }
    //    }else{
    //        self.notif = false;
    //    }
    
    //    NSLog(@"Resolving the Address");
    //    [geocoder reverseGeocodeLocation:current completionHandler:^(NSArray *placemarks, NSError *error) {
    //        //        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
    //        if (error == nil && [placemarks count] > 0) {
    //            placemark = [placemarks lastObject];
    //            self.address.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
    //                             placemark.subThoroughfare, placemark.thoroughfare,
    //                             placemark.postalCode, placemark.locality,
    //                             placemark.administrativeArea,
    //                             placemark.country];
    //        } else {
    //            NSLog(@"%@", error.debugDescription);
    //        }
    //    } ];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [errorAlert show];
    
    NSLog(@"Error: %@",error.description);
    
}


@end
