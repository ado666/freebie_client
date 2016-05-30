//
//  Factory.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 26/04/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject

@property (nonatomic, strong) NSString *entity;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSMutableDictionary *objects;

//+ (Factory *) getInstance;

- (NSDictionary*) get : (NSInteger) id;
- (void) set :(NSInteger) id :(NSDictionary*) data;
- (void) populate;

@end
