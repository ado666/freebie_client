//
//  ViewController.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 29/03/15.
//  Copyright (c) 2015 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "GeoManager.h"

@interface ViewController : UIViewController
@property bool notif;
@property int last;

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSDictionary *all_offers;

- (void) testMethod;


@end

