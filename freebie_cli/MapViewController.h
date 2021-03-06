//
//  MapViewController.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 11/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *menu_buttom;
@property (weak, nonatomic) IBOutlet UIButton *filter_button;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic) BOOL inited;

- (void) userLocationChanged;

@end
