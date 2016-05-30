//
//  Utils.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 26/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "Utils.h"

@implementation Utils

static Utils *instance = nil;

+ (Utils *) getInstance {
    if (instance == nil) {
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

-(UIImage *)imageResize :(UIImage*)img To:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
