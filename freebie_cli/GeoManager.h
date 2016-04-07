//
//  GeoManager.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 31/08/15.
//  Copyright (c) 2015 Boris Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "NetContoll.h"

@interface GeoManager : NSObject

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSDictionary *all_offers;
@property (nonatomic,strong) NetContoll *netControll;

- (void)start;



@end
