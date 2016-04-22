//
//  FavoriteCell.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 21/04/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "FavoriteCell.h"
#import "AppDelegate.h"
#import "Networker.h"

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
- (IBAction)delete:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    Networker *net = appDelegate.net;
    
    NSString *aaa = [[NSNumber numberWithInteger:(NSInteger)self.compId] stringValue];
//    NSLog(@"asd %@", aaa);
    [net post:@"/user/favorite_delete" : [NSDictionary dictionaryWithObjectsAndKeys:aaa, @"company_id", nil]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"favoritesUpdated" object:nil];
    
}

@end
