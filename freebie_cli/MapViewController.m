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
#import "testtwoFrontViewController.h"
#import "UserModel.h"
#import "Utils.h"
#import "MapAnno.h"
#import "MapPoint.h"

#import "CCHMapClusterController.h"
#import "CCHMapClusterAnnotation.h"

#import "OfferDetails.h"
#import "OfferDetailsList.h"

#import "Utils.h"
#import "Networker.h"

@interface MapViewController ()
@property (strong, nonatomic) CCHMapClusterController *mapClusterController;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UserModel *user = [UserModel getInstance];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLocationChanged) name:@"userLocationChanged" object:nil];
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation=YES;
    [self.mapView setUserTrackingMode:MKUserTrackingModeNone animated:NO];
    
    MKCoordinateRegion center = MKCoordinateRegionMake(CLLocationCoordinate2DMake(user.location.coordinate.latitude, user.location.coordinate.longitude), MKCoordinateSpanMake(0.25, 0.25));
    [self.mapView setRegion:center animated: YES];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
//    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
//                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
//    self.navigationItem.leftBarButtonItem = revealButtonItem;
//    
//    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter.png"]
//                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(rightRevealToggle:)];
//    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
    
    [self.menu_buttom addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchDown];
    [self.filter_button addTarget:revealController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchDown];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(offersChanged) name:@"offerChanged" object:nil];
    
    self.mapClusterController = [[CCHMapClusterController alloc] initWithMapView:self.mapView];
    self.mapClusterController.marginFactor = 1.0;
    self.mapClusterController.cellSize = 50.0;
    self.mapClusterController.debuggingEnabled = NO;
    self.mapClusterController.delegate = self;
    
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
    
    NSMutableArray *annos = [[NSMutableArray alloc] init];
    for (NSString* offerId in of.objects){
        NSDictionary *offer = [of.objects valueForKey:offerId];
        
        if ([[user.categories_config valueForKey:[[[offer valueForKey:@"category"] valueForKey:@"id"] stringValue]] integerValue] == 1){
            NSArray *addresses = [offer valueForKey:@"addresses"];
            for (NSDictionary *address in addresses){
                double lat = [[address valueForKey:@"lat"] doubleValue];
                double lng = [[address valueForKey:@"lng"] doubleValue];
                
                [self addPinToMap:CLLocationCoordinate2DMake(lat, lng) : offer : address];
                [annos addObject:[self addPinToMap:CLLocationCoordinate2DMake(lat, lng) : offer : address]];
                
            }
        }
        
    }
    [self.mapClusterController removeAnnotations:self.mapClusterController.annotations.allObjects withCompletionHandler:NULL];
    for (id<MKOverlay> overlay in self.mapView.overlays) {
        [self.mapView removeOverlay:overlay];
    }
    [self.mapClusterController addAnnotations:annos withCompletionHandler:NULL];
}

- (MKPointAnnotation*)addPinToMap: (CLLocationCoordinate2D) coords :(NSDictionary*) data :(NSDictionary*) address
{
    Networker *net = [Networker getInstance];
    MapPoint *point = [[MapPoint alloc] init];
    
//    @property (nonatomic, copy) NSArray                     * addresses;
//    @property (nonatomic, copy) NSDictionary                * address;
//    @property (nonatomic, copy) NSString                    * desc;
//    @property (nonatomic)       NSInteger                   offerId;
//    @property (nonatomic, copy) NSString                    * offerName;
//    @property (nonatomic, copy) NSString                    * offerDesc;
//    
//    @property (nonatomic, copy) NSString                    * title;
//    @property (nonatomic, copy) NSString                    * subtitle;
//    
//    @property (nonatomic, assign) CLLocationCoordinate2D    coordinate;
//    @property (nonatomic, strong) NSString                  * ico;
//    NSLog(@"asd %@", data);
    point.coordinate = coords;
    point.title = [data valueForKey:@"name"];
//point.ico = [net getImage:[data valueForKey:@"icon"] :@"/img/blank.png"];
    point.ico = [data valueForKey:@"icon"];
    
    point.category = [[[data valueForKey:@"category"] valueForKey:@"id"] integerValue];
    
    point.offerId = [[data valueForKey:@"id"] integerValue];
    point.offerName = [data valueForKey:@"name"];
    point.offerDesc = [data valueForKey:@"desc"];
    point.address = address;
    point.companyId = [[data valueForKey:@"compId"] integerValue];
    
    return point;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(CCHMapClusterAnnotation *)annotation {
    MKAnnotationView *annotationView;
    
    Utils *utils = [Utils getInstance];
    Networker *net = [Networker getInstance];
    
    if ([annotation isKindOfClass:CCHMapClusterAnnotation.class]) {
        static NSString *identifier = @"clusterAnnotation";
        
        MapAnno *clusterAnnotationView = (MapAnno *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (clusterAnnotationView) {
            clusterAnnotationView.annotation = annotation;
        } else {
            clusterAnnotationView = [[MapAnno alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            clusterAnnotationView.canShowCallout = YES;
        }
        
        clusterAnnotationView.uniqLocation = annotation.isUniqueLocation;
        clusterAnnotationView.cluster = annotation.isCluster;
        clusterAnnotationView.count = annotation.annotations.count;
        
        if (annotation.annotations.count == 1){
            NSArray *annotations = [annotation.annotations.allObjects subarrayWithRange:NSMakeRange(0, 1)];
            MapPoint *annotatonPin = [annotations objectAtIndex:0];
            clusterAnnotationView.category = annotatonPin.category;
            clusterAnnotationView.ico = annotatonPin.ico;
            clusterAnnotationView.offerName = annotatonPin.offerName;
            clusterAnnotationView.offerDesc = annotatonPin.offerDesc;
            clusterAnnotationView.offerId = annotatonPin.offerId;
            clusterAnnotationView.address = annotatonPin.address;
            clusterAnnotationView.companyId = annotatonPin.companyId;
            
            NSString *alt = @"http://freebieapp.ru/img/offers/empty_logo.png";
            NSString *target = [NSString stringWithFormat:@"http://freebieapp.ru/img/offers/%@.png", annotatonPin.ico];
            
            UIImage *ico = [net getImage:target : alt];
            UIImageView *imageView = [[UIImageView alloc]
                                      initWithImage:
                                      [utils imageResize:ico To:CGSizeMake(16.0, 16.0)]
                                      ];
            clusterAnnotationView.leftCalloutAccessoryView = imageView;
        }else{
            UIView *view = [[UIView alloc] init];
            UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
            [yourLabel setText:@"Подробнее..."];
            [yourLabel setTextColor:[UIColor blackColor]];
            [yourLabel setBackgroundColor:[UIColor clearColor]];
            [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
            [view addSubview:yourLabel];
            clusterAnnotationView.annotations = annotation.annotations;
        }
        
        
        
        clusterAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView = clusterAnnotationView;
    }
    
    return annotationView;
}

- (void) mapView:(MKMapView *)mapView annotationView:(MapAnno *)view calloutAccessoryControlTapped:(UIControl *)control {
    if (view.isCluster){
        [self performSegueWithIdentifier:@"OfferDetailsListSegue" sender:view];
    }else{
        [self performSegueWithIdentifier:@"OfferDetailsSegue" sender:view];
    }
    
    
}

#pragma mark reuse
- (void)mapClusterController:(CCHMapClusterController *)mapClusterController willReuseMapClusterAnnotation:(CCHMapClusterAnnotation *)mapClusterAnnotation
{
    
    if (mapClusterAnnotation.annotations.count == 1){
        
    }else{
        MapAnno *clusterAnnotationView = (MapAnno *)[self.mapView viewForAnnotation:mapClusterAnnotation];
        clusterAnnotationView.uniqLocation = mapClusterAnnotation.isUniqueLocation;
        clusterAnnotationView.cluster = mapClusterAnnotation.isCluster;
        clusterAnnotationView.count = mapClusterAnnotation.annotations.count;

    }
}


#pragma mark - titles
- (NSString *)mapClusterController:(CCHMapClusterController *)mapClusterController titleForMapClusterAnnotation:(CCHMapClusterAnnotation *)mapClusterAnnotation
{
    NSUInteger numAnnotations = mapClusterAnnotation.annotations.count;
    NSString *unit;
    
    if (numAnnotations == 1){
        NSArray *annotations = [mapClusterAnnotation.annotations.allObjects subarrayWithRange:NSMakeRange(0, numAnnotations)];
        return [annotations[0] valueForKey:@"title"];
    }else if (numAnnotations >= 2 && numAnnotations < 5){
        unit = @"Акции";
    }else{
        unit = @"Акций";
    }
    
    return [NSString stringWithFormat:@"%tu %@", numAnnotations, unit];
}

- (NSString *)mapClusterController:(CCHMapClusterController *)mapClusterController subtitleForMapClusterAnnotation:(CCHMapClusterAnnotation *)mapClusterAnnotation
{
    NSUInteger numAnnotations = MIN(mapClusterAnnotation.annotations.count, 5);
    if (numAnnotations == 1){
        return @"";
    }
    NSArray *annotations = [mapClusterAnnotation.annotations.allObjects subarrayWithRange:NSMakeRange(0, numAnnotations)];
    NSArray *titles = [annotations valueForKey:@"title"];
    return [titles componentsJoinedByString:@", "];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"OfferDetailsSegue"])
    {
        OfferDetails *target = segue.destinationViewController;
        MapAnno *annotationView = sender;
        
        [target setAnnotation:annotationView];
    }
    if ([segue.identifier isEqualToString:@"OfferDetailsListSegue"])
    {
        OfferDetailsList *target = segue.destinationViewController;
        MapAnno *annotationView = sender;
        
        [target setAnnotations: annotationView.annotations];
//        MKAnnotationView *annotationView = sender;
//        [segue.destinationViewController setAnnotations:annotationView];
    }
}


@end
