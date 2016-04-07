//
//  AppDelegate.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 29/03/15.
//  Copyright (c) 2015 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeoManager.h"
#import "NetContoll.h"
#import "Networker.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) GeoManager *geoManager;
@property (nonatomic,strong) NetContoll *netControll;
@property (nonatomic, strong) NSData *token;
@property (nonatomic, strong) NSData *device_token;
@property (nonatomic) NSString *user_id;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) Networker *net;

+ (NSString*)identifierForVendor;
- (void) testMethod;


@end

