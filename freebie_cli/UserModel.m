//
//  UserModel.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 16/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "UserModel.h"
#import "Networker.h"

@implementation UserModel

static UserModel *instance = nil;
+ (UserModel *) getInstance {
    if (instance == nil) {
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

- (void) updateLocation:(CLLocation*) userCords{
    self.location = userCords;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userLocationChanged" object:nil];
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString stringWithFormat:@"%f", userCords.coordinate.latitude], @"lat",
                          [NSString stringWithFormat:@"%f", userCords.coordinate.longitude], @"lng", nil];
    
    Networker *net = [Networker getInstance];
    
    [net post:@"/user/update_location" :data];
}

- (void) fetch {
    Networker *net = [Networker getInstance];
    
    NSDictionary *data = [net get:@"/user/get" :nil];
    
    self.categories = [NSArray arrayWithArray:[data valueForKey:@"categories"]];
    self.categories_config = [NSMutableDictionary dictionaryWithDictionary:[data valueForKey:@"categories_config"]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"categoriesChanged" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"categoriesConfigChanged" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"offerChanged" object:nil];
}

@end
