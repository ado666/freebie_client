//
//  Networker.h
//  freebie
//
//  Created by Boris Kuznetsov on 19/04/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Networker : NSObject

+ (Networker *) getInstance;

- (NSDictionary *) post: (NSString*)url :(NSDictionary*) data;
- (NSDictionary *) get: (NSString*)url :(NSDictionary*) data;
- (UIImage *) getImage: (NSString*)url :(NSString*) alt;

@property (nonatomic, strong) NSString *url;

@end
