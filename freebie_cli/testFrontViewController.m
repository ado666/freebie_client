//
//  testFrontViewController.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 05/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "testFrontViewController.h"

#import "SWRevealViewController.h"

@interface testFrontViewController ()

@end

@implementation testFrontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Front View", nil);
    
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                              style:UIBarButtonItemStylePlain target:revealController action:@selector(rightRevealToggle:)];
    
    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@" asd %@", segue.identifier);
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
