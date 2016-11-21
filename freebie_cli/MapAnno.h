//
//  MapAnno.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 04/07/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnno : MKAnnotationView

@property (nonatomic) NSUInteger count;

@property (nonatomic, getter=isUniqLocation) BOOL uniqLocation;
@property (nonatomic, getter=isCluster) BOOL cluster;

@property (nonatomic, copy) NSArray * addresses;
@property (nonatomic, copy) NSDictionary * address;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic) NSInteger offerId;
@property (nonatomic, copy) NSString * offerName;
@property (nonatomic, copy) NSString * offerDesc;

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString *ico;
@property (nonatomic) NSInteger category;

@property (nonatomic) NSInteger companyId;

@property (nonatomic) NSSet *annotations;

@end
