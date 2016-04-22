//
//  FavoritesController.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 21/04/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "FavoritesController.h"
#import "AppDelegate.h"
#import "Networker.h"
#import "FavoriteCell.h"

@interface FavoritesController ()

@end

@implementation FavoritesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    Networker *net = appDelegate.net;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFavorites) name:@"favoritesUpdated" object:nil];
    
    NSDictionary *data = [net post:@"/user/favorites" : [[NSDictionary alloc] init]];
    
    self.favorites = [data valueForKey:@"favorites"];
    
//    for (NSDictionary *f in favorites){
//        UITableViewCell *cell = [[UITableViewCell alloc] init];
//        [self inse]
//    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) updateFavorites {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    Networker *net = appDelegate.net;
    
    NSDictionary *data = [net post:@"/user/favorites" : [[NSDictionary alloc] init]];
    
    self.favorites = [data valueForKey:@"favorites"];
    
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
    return [self.favorites count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier =@"Cell";
    FavoriteCell *cell = (FavoriteCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *comp = [[self.favorites objectAtIndex:indexPath.row] valueForKey:@"company"];
    
    cell.name.text = [comp valueForKey:@"name"];
    
    cell.compId = [[comp valueForKey:@"id"] integerValue];
    
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
