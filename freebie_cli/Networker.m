//
//  Networker.m
//  freebie
//
//  Created by Boris Kuznetsov on 30/09/15.
//  Copyright © 2015 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Networker.h"
#import "AppDelegate.h"

@implementation Networker

static Networker *instance = nil;

+ (Networker *) getInstance {
    if (instance == nil) {
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

- (id) init {
    self = [super init];
    
    self.url = @"http://freebieapp.ru";
    
    return self;
}

- (NSString*) dictToString: (NSDictionary*) data {
    NSString *extraString = [NSString stringWithFormat:@"push_id=%@&uuid=%@", [AppDelegate tokenForPush], [AppDelegate identifierForVendor]];
    for (NSString* key in data) {
        id value = [data objectForKey:key];
        NSString *strvalue = [[NSString alloc] initWithString:value];
        
        extraString = [extraString stringByAppendingString:@"&"];
        extraString = [extraString stringByAppendingString:key];
        extraString = [extraString stringByAppendingString:@"="];
        extraString = [extraString stringByAppendingString:strvalue];
    }
    return extraString;
}

- (NSDictionary*) get: (NSString*)url :(NSDictionary *)extra {
    url = [self.url stringByAppendingString:url];
    
    NSString *extraString = [self dictToString: extra];
    
    NSError *error = nil; NSURLResponse *response = nil;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[extraString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    NSString *rrr= [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//    NSLog(@"asddd %@", rrr);
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    
    NSDictionary* income_data = [json objectForKey:@"data"];
    
    return income_data;
}

- (NSDictionary*) post: (NSString*)url :(NSDictionary *)extra {
    url = [self.url stringByAppendingString:url];
    
    NSString *extraString = [self dictToString: extra];
    
    NSError *error = nil; NSURLResponse *response = nil;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[extraString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    return json;
}

- (UIImage*) getImage: (NSString *)fileURL :(NSString *)alt {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    if (result == nil){
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:alt]];
        result = [UIImage imageWithData:data];
        return result;
    }
    
    return result;
}

@end

