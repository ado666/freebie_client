//
//  MapControll.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 04/02/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "MapControll.h"
#import "MapAnnotatin.h"
#import "MapPopup.h"
#import "Networker.h"
#import "AppDelegate.h"
#import "OfferDetails.h"
#import <MapKit/MapKit.h>

@implementation MapControll

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.showsUserLocation=YES;
    self.mapView.delegate = self;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}

- (void)addPinToMap: (CLLocationCoordinate2D) coords :(NSDictionary*) data
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    Networker *net = appDelegate.net;
    
//    NSString *title = [data valueForKey:@"title"];
    NSString *title = [[[data valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"name"];
    NSString *desc = [data valueForKey:@"desc"];
    NSString *icon = [data valueForKey:@"icon"];
    
    MapAnnotation *toAdd = [[MapAnnotation alloc] init];

    toAdd.coordinate = coords;
    toAdd.addresses = [data valueForKey:@"addresses"];
    toAdd.title = title;
    toAdd.offerName = [data valueForKey:@"name"];
    toAdd.offerDesc = [data valueForKey:@"desc"];
    
    if (!icon){
        icon = @"empty_logo";
    }
    NSString *target = [@"http://freebieapp.ru/img/offers/" stringByAppendingString:icon];
    NSString *target1 = [target stringByAppendingString:@".png"];
    NSString *alt = @"http://freebieapp.ru/img/offers/empty_logo.png";
    
    toAdd.ico = [net getImage:target1 : alt];

    [self.mapView addAnnotation:toAdd];
}

-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (MKAnnotationView *)mapView:(MKMapView *)mapview viewForAnnotation:(MapAnnotation*)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    annotationView.canShowCallout = true;
    
    annotationView.image = [self imageResize:[UIImage imageNamed:@"pin2.png"] andResizeTo:CGSizeMake(32,32)];
    
    UIImageView *imageView = [[UIImageView alloc]
                              initWithImage:
                                [self imageResize:annotation.ico andResizeTo:CGSizeMake(60,50)]
                              ];
    
    UIButton *info = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    annotationView.rightCalloutAccessoryView = info;
    annotationView.leftCalloutAccessoryView = imageView;
    
    return annotationView;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"OfferDetailsSegue"])
    {
        MKAnnotationView *annotationView = sender;
        [segue.destinationViewController setAnnotation:annotationView.annotation];
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"OfferDetailsSegue" sender:view];
    
}

@end
