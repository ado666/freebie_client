//
//  Networker.m
//  skirmish
//
//  Created by Boris Kuznetsov on 30/09/15.
//  Copyright © 2015 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Networker.h"
#import "AppDelegate.h"
//#import "User.h"

@implementation Networker

- (NSString*) dictToString: (NSDictionary*) data
{
    NSString *extraString = @"";
    for (NSString* key in data) {
        id value = [data objectForKey:key];
//        NSString *strvalue = (NSString *)value;
        NSString *strvalue = [[NSString alloc] initWithString:value];
//        NSLog(@"asd %i", [strvalue isKindOfClass:[NSString class]]);
        extraString = [extraString stringByAppendingString:key];
        extraString = [extraString stringByAppendingString:@"="];
        extraString = [extraString stringByAppendingString:strvalue];
        extraString = [extraString stringByAppendingString:@"&"];
    }
    return extraString;
}

-(NSDictionary*) get: (NSString*)url :(NSDictionary *)extra
{
    UIApplication *app = [[UIApplication sharedApplication] delegate];
    NSString *dtoken = [NSString stringWithFormat:@"%@", [app valueForKey:@"device_token"]];
    url = [@"http://91.225.238.186:10000" stringByAppendingString:url];
    
    NSString *extraString = [self dictToString: extra];
    extraString = [extraString stringByAppendingString:@"push_id="];
    extraString = [extraString stringByAppendingString:dtoken];
    
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
    
    NSDictionary* income_data = [json objectForKey:@"data"];
    
    return income_data;
}

-(UIImage*) getImage: (NSString *)fileURL :(NSString *)alt {
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

-(NSDictionary*) post: (NSString*)url :(NSDictionary *)extra
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *dtoken = [NSString stringWithFormat:@"%@", [appDelegate valueForKey:@"device_token"]];
    
    url = [@"http://91.225.238.186:80" stringByAppendingString:url];
    
    NSString *extraString = [self dictToString: extra];
    extraString = [extraString stringByAppendingString:@"push_id="];
    extraString = [extraString stringByAppendingString:dtoken];
    extraString = [extraString stringByAppendingString:@"&"];
    extraString = [extraString stringByAppendingString:@"uuid="];
    extraString = [extraString stringByAppendingString:[AppDelegate identifierForVendor]];

    NSError *error = nil; NSURLResponse *response = nil;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    [request setHTTPBody:[extraString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    NSLog(@"dsa %@ %@", data, error);
    
//    return [[NSDictionary alloc] init];
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
//    NSLog(@"%@" ,json);
//    NSDictionary *result    = [json objectForKey:@"result"];
    return json;
    
//    NSLog(@"post response %@", json);
    
//    NSString *status        = [json objectForKey:@"status"];
//    NSDictionary *payload   = [json objectForKey:@"payload"];
//    
//    if ([payload objectForKey:@"player"]){
//        [appDelegate.user changed:[payload objectForKey:@"player"]];
//    }
//    
//    if ([payload objectForKey:@"games"]){
//        [appDelegate.gameFactory all:[payload objectForKey:@"games"]];
////        [appDelegate.gameFactory setValue:[payload objectForKey:@"games"] forKey:@"entities"];
////        [[NSNotificationCenter defaultCenter] postNotificationName:@"entities" object:nil];
//    }
//    
//    if ([payload objectForKey:@"game"]){
////        NSLog(@"payload game %@", payload);
//        NSDictionary* game = [payload objectForKey:@"game"];
//        [appDelegate.gameFactory changedData:game];
//        
////        [appDelegate.game setQuestions:[game valueForKey:@"questions"]];
////        [appDelegate.game setStep:[game valueForKey:@"step"]];
//        
////        [appDelegate.game setTurn:[game valueForKey:@"turn"]];
////        [appDelegate.game setRounds:[game valueForKey:@"rounds"]];
////        [appDelegate.game setCurrent_round:[game valueForKey:@"current_round"]];
//        appDelegate.game.gameId = [game valueForKey:@"id"];
//    }
    
//    return result;
}

@end

