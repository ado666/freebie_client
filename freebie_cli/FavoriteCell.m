//
//  FavoriteCell.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 21/04/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "FavoriteCell.h"

@implementation FavoriteCell

@synthesize name = _name;
@synthesize icon = _icon;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
