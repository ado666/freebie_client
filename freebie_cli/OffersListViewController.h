//
//  OffersListViewController.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 19/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OffersListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *tableData;
@end
