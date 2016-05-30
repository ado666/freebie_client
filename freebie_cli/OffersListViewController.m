//
//  OffersListViewController.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 19/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "OffersListViewController.h"
#import "OffersListViewCell.h"
#import "SWRevealViewController.h"

#import "OfferFactory.h"
#import "OfferDetails.h"

@interface OffersListViewController ()

@end

@implementation OffersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    NSDictionary *all = [OfferFactory getInstance].objects;
    
    NSMutableArray *tableData = [[NSMutableArray alloc] init];
    for (NSDictionary* item in all){
        [tableData addObject:[all objectForKey:item]];
    }
    self.tableData = [NSArray arrayWithArray:tableData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"base";
    
    OffersListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//    }
//
    NSDictionary *data = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = [[self.tableData objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    cell.compName = [data valueForKey:@"name"];
    cell.compDesc = [data valueForKey:@"desc"];
    cell.compIcon = [data valueForKey:@"icon"];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.tableData count];    //count number of row from counting array hear cataGorry is An Array
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(OffersListViewCell *)sender
{
//    NSLog(@"sender is %@", sender);
    if ([segue.identifier isEqualToString:@"OfferDetailsSegue"])
    {
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                              sender.compName, @"compName",
                              sender.compDesc, @"compDesc",
                              sender.compIcon, @"compIcon", nil];
        
        OfferDetails *target = segue.destinationViewController;
        [target setNewOffer:data];
//        NSLog(@"asd %@", data);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
