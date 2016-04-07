//
//  NetContoll.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 05/08/15.
//  Copyright (c) 2015 Boris Kuznetsov. All rights reserved.
//

#import "NetContoll.h"
#import "AppDelegate.h"

@implementation NetContoll

- (id)init
{
    self = [super init]; //вызываем конструктор базового класса для
//    NSLog(@"init");
    //инициализации его инвариантов
    if (self) //если в конструкторе базового класса все прошло удачно
        //и он вернул корректный объект, а не освободив память вернул nil
    {
        //то тут можно смело инициализировать свои инварианты
    }
    
//    NSDictionary *offers = [[NSDictionary alloc] init];
//    NSDictionary *addresses = [[NSDictionary alloc] init];
    
    return self; //и возвращать самого себя
}


- (NSDictionary*)get:(NSString*)url :(NSDictionary*)params {
    NSLog(@"%@ %@", url, params);
    
    return [[NSDictionary alloc] init];
}

- (void)populateAddresses{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://91.225.238.186/address/all"]];
    request.HTTPMethod = @"GET";
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    self.addresses = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}

- (void)populateOffers {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://91.225.238.186/offers/all"]];
    request.HTTPMethod = @"GET";
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    self.offers = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}

- (void)updateLocation :(double)lng :(double)lat {
    //    CLLocation *target = [[CLLocation alloc] initWithLatitude:55.757876 longitude:37.658470];
    //    NSLog(@"update");
        //        self.lon.text = [NSString stringWithFormat:@"%.8f", current.coordinate.longitude];
        //        self.lat.text = [NSString stringWithFormat:@"%.8f", current.coordinate.latitude];

    
    // request
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://91.225.238.186/user/update_location"]];
    request.HTTPMethod = @"POST";
    NSString *stringData = [NSString stringWithFormat:@"user=%@;lng=%.8f;lat=%.8f;user=%@", [AppDelegate identifierForVendor], lng, lat, appDelegate.user_id];
    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = requestBodyData;
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
//    // Create the request.
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]];
//    
//    // Specify that it will be a POST request
//    request.HTTPMethod = @"POST";
//    
//    // This is how we set header fields
//    [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    
//    // Convert your data and set your request's HTTPBody property
//    NSString *stringData = @"some data";
//    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
//    request.HTTPBody = requestBodyData;
//    
//    // Create url connection and fire request
//    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (error == nil)
    {
//        self.all_offers = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        //        all_offers = dictionary;
        //        for (NSDictionary *key in dictionary){
        //            NSLog(@"%@", key);
        //        }
    }
}

@end
