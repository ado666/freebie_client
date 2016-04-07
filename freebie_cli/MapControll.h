//
//  MapControll.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 04/02/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapControll : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) UIPopoverController *popover;

- (void) addPinToMap:(CLLocationCoordinate2D)coords : (NSDictionary*)data;
//- (void) addPinToMap:(CLLocationCoordinate2D)coords : (NSString*)name : (NSString*)title: (NSString*) icon;
//- (UIView*) detailViewForAnnotation;
@end