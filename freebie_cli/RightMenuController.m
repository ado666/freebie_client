//
//  RightMenuController.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 19/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "RightMenuController.h"
#import "UserModel.h"
#import "CategoryViewCell.h"
#import "Networker.h"

@interface RightMenuController ()

@end

@implementation RightMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoriesChanged) name:@"categoriesChanged" object:nil];
    self.tableData = [NSArray arrayWithArray:[UserModel getInstance].categories];
}

- (void) categoriesChanged {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserModel *user = [UserModel getInstance];
    
    CategoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"base" forIndexPath:indexPath];
    NSDictionary *cellData = [self.tableData objectAtIndex:(indexPath.row)];
    
    cell.categoryName.text = [cellData valueForKey:@"name"];
    
    [cell.categoryImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"category_%@.png", [cellData valueForKey:@"id"]]]];
    cell.categoryId = [cellData valueForKey:@"id"];
    
    if ([user.categories_config valueForKey:[[cellData valueForKey:@"id"] stringValue]]){
        if ([[user.categories_config valueForKey:[[cellData valueForKey:@"id"] stringValue]] integerValue] == 1){
            cell.isOn = true;
            cell.categoryImage.alpha = 1.0f;
        }else{
            cell.isOn = false;
            cell.categoryImage.alpha = 0.25f;
        }
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
