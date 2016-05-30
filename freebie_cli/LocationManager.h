//
//  LocationManager.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 16/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

//@interface MapViewController : UIViewController <MKMapViewDelegate>

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *cclManager;

- (void) start;
+ (LocationManager *) getInstance;

@end
