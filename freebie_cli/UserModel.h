//
//  UserModel.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 16/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UserModel : NSObject

+ (UserModel *) getInstance;

- (void) updateLocation: (CLLocation*) userCords;
- (void) fetch;

@property (nonatomic) CLLocation* location;
@property (nonatomic) NSArray* categories;
@property (nonatomic) NSMutableDictionary* categories_config;

@end
