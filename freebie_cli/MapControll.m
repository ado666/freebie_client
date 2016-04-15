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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFilter) name:@"filterUpdate" object:nil];

}

@synthesize offers;
- (void) setOffers:(NSMutableArray *)val{
    offers = val;
    [self updatePins];
}
- (NSMutableArray*) offers {
    return offers;
}

- (void) updatePins {
    [_mapView removeAnnotations:_mapView.annotations];
    
    UIView *view = self.filterContent.subviews[0];
    BOOL food = [[view viewWithTag:1] isOn];
    BOOL bar = [[view viewWithTag:2] isOn];
    BOOL men = [[view viewWithTag:5] isOn];
    BOOL women = [[view viewWithTag:6] isOn];
    BOOL kids = [[view viewWithTag:7] isOn];
    
    for (NSDictionary *offer in self.offers){
        NSArray *addresses = [offer valueForKey:@"addresses"];
        for (NSDictionary *address in addresses){
            double lat = [[address valueForKey:@"lat"] doubleValue];
            double lng = [[address valueForKey:@"lng"] doubleValue];

            if ([[[offer valueForKey:@"category"] valueForKey:@"id"] integerValue] == 1){
                if (food){
                    [self addPinToMap:CLLocationCoordinate2DMake(lat, lng) : offer];
                }
            }
            if ([[[offer valueForKey:@"category"] valueForKey:@"id"] integerValue] == 2){
                if (bar){
                    [self addPinToMap:CLLocationCoordinate2DMake(lat, lng) : offer];
                }
            }
            if ([[[offer valueForKey:@"category"] valueForKey:@"id"] integerValue] == 5){
                if (men){
                    [self addPinToMap:CLLocationCoordinate2DMake(lat, lng) : offer];
                }
            }
            if ([[[offer valueForKey:@"category"] valueForKey:@"id"] integerValue] == 6){
                if (women){
                    [self addPinToMap:CLLocationCoordinate2DMake(lat, lng) : offer];
                }
            }
            if ([[[offer valueForKey:@"category"] valueForKey:@"id"] integerValue] == 7){
                if (kids){
                    [self addPinToMap:CLLocationCoordinate2DMake(lat, lng) : offer];
                }
            }
            
        }
    }
}
     
- (void) updateFilter {
    
    [self updatePins];
//    [_mapView removeAnnotations:_mapView.annotations];
    
//    for (id<MKAnnotation> annotation in _mapView.annotations){
//        MKAnnotationView* anView = [_mapView viewForAnnotation: annotation];
//        if (anView){
//            [anView setHidden:TRUE];
//            NSLog(@"aaaa %@", anView.annotation.title);
//        }
//    }
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    Networker *net = appDelegate.net;
//    
//    NSDictionary *offers = [net post:@"/offer/all_mobile" :[[NSDictionary alloc] init]];
//    
//    for (NSDictionary *offer in offers){
//        NSArray *addresses = [offer valueForKey:@"addresses"];
//        for (NSDictionary *address in addresses){
//            double lat = [[address valueForKey:@"lat"] doubleValue];
//            double lng = [[address valueForKey:@"lng"] doubleValue];
//            
//            [self addPinToMap:CLLocationCoordinate2DMake(lat, lng) : offer];
//        }
//    }
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
    toAdd.category = [[[data valueForKey:@"category"] valueForKey:@"id"] integerValue];
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
    
//    annotationView.image = [self imageResize:[UIImage imageNamed:@"pin2.png"] andResizeTo:CGSizeMake(32,32)];
    NSString *imgurl;
    if (annotation.category == 1){
        imgurl = @"pin_food.png";
    }else if (annotation.category == 2){
        imgurl = @"pin_bar.png";
    }else if (annotation.category == 5){
        imgurl = @"pin_men.png";
    }else if (annotation.category == 6){
        imgurl = @"pin_women.png";
    }else if (annotation.category == 7){
        imgurl = @"pin_kids.png";
    }
    annotationView.image = [UIImage imageNamed:imgurl];
    
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
