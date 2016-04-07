//
//  NetContoll.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 05/08/15.
//  Copyright (c) 2015 Boris Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetContoll : NSObject

@property (nonatomic,strong) NSDictionary *offers;
@property (nonatomic,strong) NSDictionary *addresses;

- (NSDictionary*)get: (NSString*)url : (NSDictionary*)params;
- (void)updateLocation: (double)lng :(double)lat;
- (void)populateOffers;
- (void)populateAddresses;


@end
