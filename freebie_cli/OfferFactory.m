//
//  OfferFactory.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 26/04/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "OfferFactory.h"

@implementation OfferFactory

//static NSString *entity = @"offer";
//static NSString *url = @"offer/all_mobile";

static OfferFactory *instance = nil;
+ (OfferFactory *) getInstance {
    if (instance == nil) {
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

- (id) init {
    self = [super init];
    
    self.entity = @"offer";
    self.url = @"/offer/all_mobile";
    
    return self;
}

@end
