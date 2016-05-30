//
//  Utils.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 26/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (Utils *) getInstance;

- (UIImage*) imageResize :(UIImage*)image To:(CGSize)size;

@end
