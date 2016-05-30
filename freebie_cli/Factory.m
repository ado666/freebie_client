//
//  Factory.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 26/04/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "Factory.h"
#import "Networker.h"

@implementation Factory

//static NSString *entity = @"";
//static NSString *url = @"";

//static Factory *instance = nil;
//+ (Factory *) getInstance {
//    if (instance == nil) {
//        instance = [[super allocWithZone:NULL] init];
//    }
//    return instance;
//}

- (id) init {
    if (self = [super init]){
        self.objects = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (NSDictionary*) get :(NSInteger)id {
    return [self.objects valueForKey:[[NSNumber numberWithInteger:id] stringValue]];
}
- (void) set :(NSInteger)id :(NSDictionary*)data{
    [self.objects setValue:data forKey:[[NSNumber numberWithInteger:id] stringValue]];
//    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@Changed", entity] object:nil];
}
- (void) populate {
    Networker *net = [Networker getInstance];
    
    NSDictionary *data = [net post:self.url :[[NSDictionary alloc] init]];
    
    for (NSDictionary *item in data){
        [self set:[[item valueForKey:@"id"] integerValue] :item];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@Changed", self.entity] object:nil];
}


@end
