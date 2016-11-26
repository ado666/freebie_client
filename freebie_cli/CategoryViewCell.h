//
//  CategoryViewCell.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 23/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewCell : UITableViewCell

@property (nonatomic) id categoryId;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (weak, nonatomic) IBOutlet UISwitch *categorySwitch;
@property (nonatomic) BOOL isOn;

@end
