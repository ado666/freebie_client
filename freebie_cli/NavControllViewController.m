//
//  NavControllViewController.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 10/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "NavControllViewController.h"

@interface NavControllViewController ()

@end

@implementation NavControllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) ttt {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//

    // Set the title of navigation bar by using the menu items
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
//    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
//    
//    // Set the photo if it navigates to the PhotoView
//    if ([segue.identifier isEqualToString:@"showPhoto"]) {
//        UINavigationController *navController = segue.destinationViewController;
//        PhotoViewController *photoController = [navController childViewControllers].firstObject;
//        NSString *photoFilename = [NSString stringWithFormat:@"%@_photo", [menuItems objectAtIndex:indexPath.row]];
//        photoController.photoFilename = photoFilename;
//    }
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
