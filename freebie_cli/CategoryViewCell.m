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
    UITapGestureRecognizer *tapGR;
    tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGR.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGR];
}
- (IBAction)switchChanged:(id)sender {
    Networker *net = [Networker getInstance];
    UserModel *user = [UserModel getInstance];
    
    BOOL current = (self.isOn ? false : true);
    
    NSString *isOn = (current ? @"1" : @"0");
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@", self.categoryId], @"category_id", isOn, @"value", nil];
    [net post:@"/settings/category" : data];

    [user.categories_config setValue:isOn forKey:[self.categoryId stringValue]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"categoriesConfigChanged" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"offerChanged" object:nil];
    
    if (current) {
        self.categoryImage.alpha = 0.5f;
    }else{
        self.categoryImage.alpha = 1.0f;
    }
}

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    Networker *net = [Networker getInstance];
    UserModel *user = [UserModel getInstance];
    
    BOOL current = (self.isOn ? false : true);
    self.isOn = current;
    
    NSString *isOn = (current ? @"1" : @"0");
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@", self.categoryId], @"category_id", isOn, @"value", nil];
    NSLog(@"asd %@" ,data);
    [net post:@"/settings/category" : data];
    
    [user.categories_config setValue:isOn forKey:[self.categoryId stringValue]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"categoriesConfigChanged" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"offerChanged" object:nil];
    
    if (self.isOn) {
        self.categoryImage.alpha = 1.0f;
    }else{
        self.categoryImage.alpha = 0.25f;
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
