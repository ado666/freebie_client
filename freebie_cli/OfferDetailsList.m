//
//  OfferDetailsList.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 06/08/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "OfferDetailsList.h"
#import "OfferDetailsTableCell.h"
#import "MapAnno.h"
#import "OfferDetails.h"
#import "OfferDetailsTableCell.h"

@interface OfferDetailsList ()

@end

@implementation OfferDetailsList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void) setAnnotations:(NSSet *)annotation {
    self.tableData = [annotation allObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)go_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark offersList
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"address";
    
    OfferDetailsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//    NSLog(@"asddsa %@" ,self.tableData);
    MapAnno *anno = [self.tableData objectAtIndex:indexPath.row];
    
    cell.offer_name.text = anno.offerName;
    cell.annotation = anno;
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.tableData count];    //count number of row from counting array hear cataGorry is An Array
}



#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(OfferDetailsTableCell *)sender
{
     if ([segue.identifier isEqualToString:@"OfferDetailsSegue"]){
         OfferDetails *target = segue.destinationViewController;
         [target setAnnotation:sender.annotation];
 
     }
}


@end
