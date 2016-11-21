//
//  MapAnno.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 04/07/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "MapAnno.h"

#import "Utils.h"

@interface MapAnno ()
@property (nonatomic) UIImage *pinIcon;
@end

@implementation MapAnno

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setCount:1];
    }
    return self;
}

#pragma setters
- (void)setUniqLocation:(BOOL)uniqLocation
{
    _uniqLocation = uniqLocation;
    [self setNeedsLayout];
}
- (void)setCount:(NSUInteger)count
{
    _count = count;
    [self setNeedsLayout];
}

- (void) layoutSubviews {
    Utils *utils = [Utils getInstance];
    NSString *imageName = ((self.isUniqLocation && self.count > 1) || self.isCluster) ? @"pin.png" : [NSString stringWithFormat:@"pin%ld.png", self.category];
    self.image = [utils imageResize: [UIImage imageNamed:imageName] To:CGSizeMake(20, 32)];
}

@end
