//
//  MapViewController.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 11/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"
#import "OfferFactory.h"
#import "MapAnnotatin.h"
#import "Networker.h"
#import "ViewController.h"
#import "testtwoFrontViewController.h"
#import "UserModel.h"
#import "Utils.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UserModel *user = [UserModel getInstance];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLocationChanged) name:@"userLocationChanged" object:nil];
    
    self.mapView.showsUserLocation=YES;
    self.mapView.delegate = self;
    [self.mapView setUserTrackingMode:MKUserTrackingModeNone animated:NO];
    
    MKCoordinateRegion center = MKCoordinateRegionMake(CLLocationCoordinate2DMake(user.location.coordinate.latitude, user.location.coordinate.longitude), MKCoordinateSpanMake(0.25, 0.25));
    [self.mapView setRegion:center animated: YES];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(rightRevealToggle:)];
    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(offersChanged) name:@"offerChanged" object:nil];
    
    [self offersChanged];
}

- (void) userLocationChanged {
    if (self.inited){
        return;
    }else{
        UserModel *user = [UserModel getInstance];
        MKCoordinateRegion center = MKCoordinateRegionMake(CLLocationCoordinate2DMake(user.location.coordinate.latitude, user.location.coordinate.longitude), MKCoordinateSpanMake(0.25, 0.25));
        [self.mapView setRegion:center animated: YES];
        
        self.inited = YES;
    }
}

- (void) offersChanged {
    OfferFactory *of = [OfferFactory getInstance];
    UserModel *user = [UserModel getInstance];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
//    NSLog(@"ssss %@", user.categories_config);
    for (NSString* offerId in of.objects){
        NSDictionary *offer = [of.objects valueForKey:offerId];
        
        if ([[user.categories_config valueForKey:[[[offer valueForKey:@"category"] valueForKey:@"id"] stringValue]] integerValue] == 1){
            NSArray *addresses = [offer valueForKey:@"addresses"];
            for (NSDictionary *address in addresses){
                double lat = [[address valueForKey:@"lat"] doubleValue];
                double lng = [[address valueForKey:@"lng"] doubleValue];
                
                [self addPinToMap:CLLocationCoordinate2DMake(lat, lng) : offer];
            }
        }
        
    }
//    [self setOffers:temp];
}

- (void)addPinToMap: (CLLocationCoordinate2D) coords :(NSDictionary*) data
{
    Networker *net = [Networker getInstance];
    
    //    NSString *title = [data valueForKey:@"title"];
    NSString *title = [[[data valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"name"];
    NSString *desc = [data valueForKey:@"desc"];
    NSString *icon = [data valueForKey:@"icon"];
//    NSLog(@"data %@", data);
    
    MapAnnotation *toAdd = [[MapAnnotation alloc] init];
    
    toAdd.coordinate = coords;
    toAdd.addresses = [data valueForKey:@"addresses"];
    toAdd.title = title;
    toAdd.offerId = [[data valueForKey:@"id"] integerValue];
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

- (MKAnnotationView *)mapView:(MKMapView *)mapview viewForAnnotation:(MapAnnotation*)annotation
{
    Utils *utils = [Utils getInstance];
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    annotationView.canShowCallout = true;
    
    //    annotationView.image = [self imageResize:[UIImage imageNamed:@"pin2.png"] andResizeTo:CGSizeMake(32,32)];
    NSString *imgurl = [NSString stringWithFormat:@"pin_%ld.png", (long)annotation.category];
//    if (annotation.category == 1){
//        imgurl = @"pin_food.png";
//    }else if (annotation.category == 2){
//        imgurl = @"pin_bar.png";
//    }else if (annotation.category == 5){
//        imgurl = @"pin_men.png";
//    }else if (annotation.category == 6){
//        imgurl = @"pin_women.png";
//    }else if (annotation.category == 7){
//        imgurl = @"pin_kids.png";
//    }
    annotationView.image = [UIImage imageNamed:imgurl];
    
    UIImageView *imageView = [[UIImageView alloc]
                              initWithImage:
                              [utils imageResize:annotation.ico To:CGSizeMake(60,50)]
                              ];
    
    UIButton *info = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    annotationView.rightCalloutAccessoryView = info;
    annotationView.leftCalloutAccessoryView = imageView;
    
    return annotationView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
