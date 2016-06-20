//
//  OfferDetails.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 30/03/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "OfferDetails.h"
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "Networker.h"

@implementation OfferDetails

-(void) viewDidLoad {
//    self.offer = [[NSMutableDictionary alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAnno:) name:@"changeAnno" object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOffer:) name:@"changeOffer" object:self];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeAnno" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeOffer" object:self];
    
}
- (IBAction)toFavorite:(id)sender {
    Networker *net = [Networker getInstance];
    
    NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:[[self.annoView valueForKey:@"offerId"] stringValue], @"offer_id",  nil];
    
    [net post:@"/offer/toFavorites" : d];
    
    [self.star setImage:[UIImage imageNamed:@"fav_active.png"] forState:UIControlStateNormal];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.timer invalidate];
    self.timer = nil;
}

-(UIImage *)resizeImageTo :(UIImage*)img :(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void) changeAnno: (NSNotification *)notification {
    if (!self.annoView){
        return;
    }
    self.offerName.text = [self.annoView valueForKey:@"offerName"];
    self.offerDesc.text = [self.annoView valueForKey:@"offerDesc"];
    
    UIImage *scaled = [self resizeImageTo :[self.annoView valueForKey:@"ico"] :CGSizeMake(16, 16)];
    [self.offerImage setImage:scaled];
    
    NSDictionary *address = [[self.annoView valueForKey:@"addresses"] objectAtIndex:0];
    self.comName.text = [address valueForKey:@"name"];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *aLocation = [[CLLocation alloc] initWithLatitude:[[address valueForKey:@"lat"] floatValue] longitude:[[address valueForKey:@"lng"] floatValue]];
    [geocoder reverseGeocodeLocation:aLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0){
            CLPlacemark *placemark =  [placemarks objectAtIndex:0];
            NSString *address = [NSString stringWithFormat:@"%@ %@", [placemark thoroughfare], placemark.subThoroughfare];
            self.offerAddress.text = address;
        }
    }];
//    geoCoder.delegate = self;
//    [geoCoder start];
    
    NSDate *now = [NSDate date];
    NSDate *future = [now dateByAddingTimeInterval:(60*60*24+11467)];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:5];
//    today = [NSDate date];
//    NSDate *datePlusOneDay = [today dateByAddibgTimeInterval:(60 * 60 * 24)];
//    NSDateFormatter *dateformatterBehaviour = [[[NSDateFormatter alloc]init]autorelease];
//    [dateFormatter setDateFormat:@"EEEE"];
//    NSString *dateString = [dateFormatter stringFromDate:datePlusOneDay];
//    self.navigationItem.title = datestring;
    self.endTime = future;
}

- (void) changeOffer:(NSNotification *)notif {
    if (!self.offer){
        return;
    }
    self.offerDesc.text = [self.offer valueForKey:@"compName"];
    self.comName.text = [[[self.offer valueForKey:@"addresses"] objectAtIndex:0] valueForKey:@"name"];
    
    //    [self.endTime dateByAddingTimeInterval:60*60*24*3+8000];
    NSDate *now = [NSDate date];
    NSDate *future = [now dateByAddingTimeInterval:(60*60*24+11467)];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:5];
    //    today = [NSDate date];
    //    NSDate *datePlusOneDay = [today dateByAddibgTimeInterval:(60 * 60 * 24)];
    //    NSDateFormatter *dateformatterBehaviour = [[[NSDateFormatter alloc]init]autorelease];
    //    [dateFormatter setDateFormat:@"EEEE"];
    //    NSString *dateString = [dateFormatter stringFromDate:datePlusOneDay];
    //    self.navigationItem.title = datestring;
    self.endTime = future;

}

- (void) timerHandler :(NSDictionary*) userInfo{
//    unsigned int unitFlags = NSCalendarUnitDay | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSDateComponents *conversionInfo = [NSCalendar components:unitFlags fromDate:[NSDate date]  toDate:self.endTime  options:0];
    NSTimeInterval diff = [self.endTime timeIntervalSinceDate:[NSDate date]];
    int secs = (int)diff%60;
    int mins = (int)diff/60%60;
    int hrs  = (int)diff/60/60%24;
    
    NSMutableString* result = [NSMutableString stringWithFormat:@"%02d:%02d:%02d", hrs, mins, secs];
    self.offerLeft.text = result;
}

-(void) setAnnotation: (MKAnnotationView*) view {
    self.annoView = view;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeAnno" object:self];
}

-(void) setNewOffer:(NSDictionary *)offer{
//    NSLog(@"offer %@", offer);
//    [self.offer setValue: [offer valueForKey:@"compName"] forKey:@"compName"];
//    [self.offer setValue: [offer valueForKey:@"compDesc"] forKey:@"compDesc"];
//    [self.offer setValue: [offer valueForKey:@"compIcon"] forKey:@"compIcon"];
//    NSLog(@"ssss %@", self.offer);
    self.offer = offer;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeOffer" object:self];
}

@end
