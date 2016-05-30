//
//  OffersListViewCell.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 30/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OffersListViewCell : UITableViewCell

@property (weak, nonatomic) NSString *compName;
@property (weak, nonatomic) NSString *compDesc;
@property (weak, nonatomic) NSString *compIcon;

@end
