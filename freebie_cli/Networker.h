//
//  Networker.h
//  skirmish
//
//  Created by Boris Kuznetsov on 30/09/15.
//  Copyright © 2015 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Networker : NSObject

- (NSString*) dictToString: (NSDictionary*) data;

- (NSDictionary*) get :(NSString*)url :(NSDictionary*)extra;
- (NSDictionary*) post :(NSString*)url :(NSDictionary*)extra;
- (UIImage*) getImage :(NSString*)url :(NSString*)alt;
//- (NSString*) getImageFromURL :(NSString*)url;

@end