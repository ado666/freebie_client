//
//  FavoriteCell.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 21/04/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIButton *toDelete;

@property NSInteger compId;

@end
