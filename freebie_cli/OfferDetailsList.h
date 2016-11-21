//
//  OfferDetailsList.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 06/08/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapAnno.h"

@interface OfferDetailsList : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *back_buttom;
@property (nonatomic) NSArray *tableData;

-(void) setAnnotations : (NSSet*) annotations;

@end
