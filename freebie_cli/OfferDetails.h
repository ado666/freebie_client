//
//  OfferDetails.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 30/03/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface OfferDetails : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *catImage;
@property (weak, nonatomic) IBOutlet UIImageView *offerImage;
@property (weak, nonatomic) IBOutlet UILabel *comName;
@property (weak, nonatomic) IBOutlet UILabel *offerAddress;

@property (weak, nonatomic) IBOutlet UILabel *offerName;
@property (weak, nonatomic) IBOutlet UILabel *offerDesc;
@property (weak, nonatomic) IBOutlet UILabel *offerLeft;

@property (nonatomic, weak) NSTimer* timer;

@property (nonatomic,strong) MKAnnotationView *annoView;
@property (nonatomic,strong)  NSDate* endTime;

- (void) setAnnotation: (MKAnnotationView*) view;
- (void) changeAnno: (NSNotification*) notif;
- (void) timerHandler: (NSDictionary*) userInfo;

- (UIImage*) resizeImageTo :(UIImage*)img :(CGSize)size;

@end
