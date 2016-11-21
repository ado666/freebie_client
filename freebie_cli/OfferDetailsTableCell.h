//
//  OfferDetailsTableCell.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 06/08/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapAnno.h"

@interface OfferDetailsTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *offer_name;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UIImageView *to_map;

@property (nonatomic) MapAnno *annotation;

@end
