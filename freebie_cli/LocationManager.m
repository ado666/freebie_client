//
//  LocationManager.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 16/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "LocationManager.h"
#import "UserModel.h"

@implementation LocationManager

static LocationManager *instance = nil;
+ (LocationManager *) getInstance {
    if (instance == nil) {
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

- (void) start{
    self.cclManager = [[CLLocationManager alloc] init];
    self.cclManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.cclManager.delegate = self;
    [self.cclManager requestAlwaysAuthorization];
    [self.cclManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"fail");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    UserModel *user = [UserModel getInstance];
    [user updateLocation: [locations lastObject]];
}

@end
