//
//  OffersListViewCell.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 30/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "OffersListViewCell.h"
#import "OfferDetails.h"

@implementation OffersListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
//    [self performSegueWithIdentifier:@"OfferDetailsSegue" sender:view];
    // Configure the view for the selected state
}

@end
