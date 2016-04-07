//
//  AppDelegate.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 29/03/15.
//  Copyright (c) 2015 Boris Kuznetsov. All rights reserved.
//

#import "AppDelegate.h"
#import "GeoManager.h"
#import "ViewController.h"
#import "OfferInfoViewController.h"
#import "Networker.h"
#import "MapControll.h"



@interface AppDelegate ()
@end

@implementation AppDelegate

+ (NSString *) identifierForVendor
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return @"";
}

- (void) testMethod {
//    NSLog(@"app delegate");
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken  {
    self.device_token = deviceToken;
    self.token = deviceToken;
    [self hello];
//    [self.geoManager start];
    NSLog(@"My token is: %@", self.token);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Failed to get token, error: %@", error);
}

- (BOOL)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)launchOptions {
//    NSLog(@"notif %@", launchOptions);
    return YES;
}


- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
//    NSLog(@"didRegisterUser");
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
    
    };
    [[UIApplication sharedApplication] registerUserNotificationSettings:
                                            [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert |
                                                                  UIUserNotificationTypeBadge)
                                             categories:nil]];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestAlwaysAuthorization];
    
    self.net = [[Networker alloc] init];

    
//    NSLog(@"%@", launchOptions);
//    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"title"
//                                                      message:[NSString stringWithFormat:@"data=%@", [launchOptions objectForKey:@"alert"]]
//                                                     delegate:nil
//                                            cancelButtonTitle:@"Да, мой господин"
//                                            otherButtonTitles:nil];
//    
//    [message show];
//    if (!self.geoManager)   self.geoManager = [[GeoManager alloc] init];
//    if (!self.netControll)  self.netControll = [[NetContoll alloc] init];
//    
//    [self.netControll populateAddresses];
//    [self.netControll populateOffers];
    
    if (launchOptions == nil){
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main.storyboard" bundle:nil];
//        ViewController *mainViewController = (ViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
//        OfferInfoViewController *offerViewController = (OfferInfoViewController *)[storyboard instantiateViewControllerWithIdentifier:@"OfferViewController"];
//        [mainViewController testMethod];
//        OfferInfoViewController *viewController = [[OfferInfoViewController alloc] init];
//        [viewController presentViewController:offerViewController animated:YES completion:nil];
//        ViewController *main = [[ViewController alloc] init];
//        OfferInfoViewController *offerView = [[OfferInfoViewController alloc] init];
//        [main presentViewController:offerView animated:YES completion:nil];
    }
    
    // Override point for customization after application launch.
    return YES;
}
//
//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    
//    if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
//        self.locationTracker = [[DLLocationTracker alloc] init];
//        [self.locationTracker setLocationUpdatedInBackground:^(CLLocation *location) {
//            //тестовый блок, будет показывать local notification с координатами
//            UILocalNotification *notification = [[UILocalNotification alloc] init];
//            notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:15];
//            notification.alertBody = [NSString stringWithFormat:@"New location: %@", location];
//            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//        }];
//        [self.locationTracker startUpdatingLocation];
//    }
//    return TRUE;
//}

- (void)hello{
    UINavigationController *vc = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    MapControll *map = vc.viewControllers[0];
    NSDictionary *offers = [self.net post:@"/offer/all_mobile" :[[NSDictionary alloc] init]];
    
    for (NSDictionary *offer in offers){
        NSArray *addresses = [offer valueForKey:@"addresses"];
//        NSLog(@"%@", offer);
        for (NSDictionary *address in addresses){
//            NSLog(@"%@", offer);
            double lat = [[address valueForKey:@"lat"] doubleValue];
            double lng = [[address valueForKey:@"lng"] doubleValue];
//            NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
//                                  , nil]
//            NSString *icon = [offer valueForKey:@"icon"];
//            NSString *title = [offer valueForKey:@"name"];
//            NSString *text = [offer valueForKey:@"desc"];
            [map addPinToMap:CLLocationCoordinate2DMake(lat, lng) : offer];
        }
    }
    
    return;
//    UINavigationController *vc = [[[UIApplication sharedApplication] keyWindow] rootViewController];
//    [self.viewController addPinToMap:CLLocationCoordinate2D(55,37)];
//    MapControll *map = vc.viewControllers[0];
//    [map addPinToMap:CLLocationCoordinate2DMake(55, 37)];
//    NSLog(@"asd %@", array);
//    for (NSDictionary *item in array){
////        NSLog(@"asddsa %@", [array objectAtIndex:item]);
//        double lat = [[item valueForKey:@"lat"] doubleValue];
//        double lng = [[item valueForKey:@"lng"] doubleValue];
//        NSString *name = [item valueForKey:@"name"];
////
//        [map addPinToMap:CLLocationCoordinate2DMake(lat, lng) : name];
//    };
    
//    NSLog(@"asd %@", array);
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://91.225.238.186/user/hello"]];
//    
//    NSString *stringData = [NSString stringWithFormat:@"uuid=%@;token=%@", [AppDelegate identifierForVendor], self.token];
//    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
//    
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = requestBodyData;
//    
//    NSURLResponse *response = nil;
//    NSError *error = nil;
//    NSData *data = [NSURLConnection sendSynchronousRequest:request
//                                         returningResponse:&response
//                                                     error:&error];
//    
//    NSDictionary *parsed = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//    self.user_id = [parsed objectForKey:@"user"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"term");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
