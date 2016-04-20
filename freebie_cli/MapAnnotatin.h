//
//  MapAnnotatin.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 04/02/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>{
    NSArray *addresses;
    NSString *desc;
    NSInteger offerId;
    NSString *offerName;
    NSString *offerDesc;
    NSInteger category;
    
    NSString *title;
    NSString *subtitle;
    CLLocationCoordinate2D coordinate;
    UIImage *ico;
}

@property (nonatomic, copy) NSArray * addresses;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic) NSInteger offerId;
@property (nonatomic, copy) NSString * offerName;
@property (nonatomic, copy) NSString * offerDesc;

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) UIImage * ico;
@property (nonatomic) NSInteger category;

@end