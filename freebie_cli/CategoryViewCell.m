//
//  CategoryViewCell.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 23/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "CategoryViewCell.h"
#import "Networker.h"
#import "UserModel.h"

@implementation CategoryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)switchChanged:(id)sender {
    Networker *net = [Networker getInstance];
    UserModel *user = [UserModel getInstance];
    
    NSString *isOn = ([sender isOn] ? @"1" : @"0");
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@", self.categoryId], @"category_id", isOn, @"value", nil];
    [net post:@"/settings/category" : data];

    [user.categories_config setValue:isOn forKey:[self.categoryId stringValue]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"categoriesConfigChanged" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"offerChanged" object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
