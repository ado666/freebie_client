//
//  ViewController.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 29/03/15.
//  Copyright (c) 2015 Boris Kuznetsov. All rights reserved.
//

#import "ViewController.h"
#import "GeoManager.h"
#import <UIKit/UIKit.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lat;
@property (weak, nonatomic) IBOutlet UILabel *lon;
@property (weak, nonatomic) IBOutlet UILabel *acc;
@property (weak, nonatomic) IBOutlet UILabel *fil;
@property (weak, nonatomic) IBOutlet UILabel *dist;

@end


@implementation ViewController


- (void) testMethod {
    NSLog(@"view");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self.netControl sayHello];
    
//    radius = 100;

//    self.locationManager = [[CLLocationManager alloc] init];
//    
//    [self.locationManager requestAlwaysAuthorization];
////    geocoder = [[CLGeocoder alloc] init];
//    
//    self.locationManager.delegate = [[GeoManager alloc] init];
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [self.locationManager startMonitoringSignificantLocationChanges];
    
//    [self.locationManager startUpdatingLocation];
    
//    self.acc.text  = [NSString stringWithFormat:@"%f", self.locationManager.desiredAccuracy];
//    self.fil.text = [NSString stringWithFormat:@"%i", radius];
//    NSMutableData *receivedData;
    
//    // Create the request.
//    
//    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://91.225.238.186/offer/all_mobile"]
//                              
//                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
//                              
//                                          timeoutInterval:60.0];
//    
//    
//    
//    // Create the NSMutableData to hold the received data.
//    
//    // receivedData is an instance variable declared elsewhere.
//    
//    receivedData = [NSMutableData dataWithCapacity: 0];
//    
//    
//    
//    // create the connection with the request
//    
//    // and start loading the data
//    
//    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
//    
//    if (!theConnection) {
//        
//        // Release the receivedData object.
//        
//        receivedData = nil;
//        
//        
//        
//        // Inform the user that the connection failed.
//        
//    }else{
//        NSLog(@"%@", receivedData);
//    }
    
    // Send a synchronous request
//    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://91.225.238.186/offer/all_mobile"]];
//    NSURLResponse * response = nil;
//    NSError * error = nil;
//    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
//                                          returningResponse:&response
//                                                      error:&error];
//    
//    if (error == nil)
//    {
//        self.all_offers = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
////        all_offers = dictionary;
////        for (NSDictionary *key in dictionary){
////            NSLog(@"%@", key);
////        }
//    }
    
}


- (void)showMessage {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Гыг, еба"
                                                      message:@"Приперся, скотина?"
                                                     delegate:nil
                                            cancelButtonTitle:@"Да, мой господин"
                                            otherButtonTitles:nil];
    
    [message show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)tapButton:(id)sender {
//    NSLog(@"tap tap tap");
//}

//- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
//{
//    // Send a synchronous request
//    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://91.225.238.186/offer/test"]];
//    NSURLResponse * response = nil;
//    NSError * error = nil;
//    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
//                                          returningResponse:&response
//                                                      error:&error];
//    
//    if (error == nil)
//    {
//        self.all_offers = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//        //        all_offers = dictionary;
//        //        for (NSDictionary *key in dictionary){
//        //            NSLog(@"%@", key);
//        //        }
//    }
//
//}

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//{
//    NSLog(@"Launched in background %d", UIApplicationStateBackground == application.applicationState);
//    
//    return YES;
//}
//
//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
//    self.shareModel = [LocationShareModel sharedModel];
//    
//    if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
//        self.shareModel.anotherLocationManager = [[CLLocationManager alloc]init];
//        self.shareModel.anotherLocationManager.delegate = self;
//        self.shareModel.anotherLocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
//        self.shareModel.anotherLocationManager.activityType = CLActivityTypeOtherNavigation;
//        
//        if(IS_OS_8_OR_LATER) {
//            [self.shareModel.anotherLocationManager requestAlwaysAuthorization];
//        }
//        
//        [self.shareModel.anotherLocationManager startMonitoringSignificantLocationChanges];
//        
//    }    
//    return YES;
//}


@end
