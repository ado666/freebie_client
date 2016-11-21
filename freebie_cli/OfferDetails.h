//
//  OfferDetails.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 30/03/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapAnno.h"

@interface OfferDetails : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *back_button;
@property (weak, nonatomic) IBOutlet UIImageView *status_back;

@property (weak, nonatomic) IBOutlet UIImageView *header_image;
@property (weak, nonatomic) IBOutlet UIImageView *header_back;
@property (weak, nonatomic) IBOutlet UIImageView *header_line;

@property (weak, nonatomic) IBOutlet UIButton *header_star;
@property (weak, nonatomic) IBOutlet UIImageView *header_location;

@property (weak, nonatomic) IBOutlet UIImageView *header_address_icon;
@property (weak, nonatomic) IBOutlet UILabel *header_address_name;
@property (weak, nonatomic) IBOutlet UILabel *header_address_address;

@property (weak, nonatomic) IBOutlet UIImageView *content_line;
@property (weak, nonatomic) IBOutlet UIImageView *content_footer;
@property (weak, nonatomic) IBOutlet UITextView *content_offer_desc;

@property (weak, nonatomic) IBOutlet UILabel *test_name;
@property (weak, nonatomic) IBOutlet UITextView *content_offer_name;
@property (weak, nonatomic) IBOutlet UILabel *content_offer_left;


@property (strong, nonatomic) NSDictionary *offer;
@property (nonatomic, weak) NSTimer* timer;
@property (nonatomic,strong) MapAnno *annoView;
@property (nonatomic,strong)  NSDate* endTime;
@property (nonatomic) BOOL isFavorite;


- (void) setAnnotation: (MKAnnotationView*) view;
- (void) setNewOffer: (NSDictionary*) offer;
- (void) changeAnno: (NSNotification*) notif;
- (void) changeOffer: (NSNotification*) notif;
- (void) timerHandler: (NSDictionary*) userInfo;

- (UIImage*) resizeImageTo :(UIImage*)img :(CGSize)size;

@end
