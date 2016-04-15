//
//  FilterController.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 12/04/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "FilterController.h"
#import <MapKit/MapKit.h>

@interface FilterController ()

@end

@implementation FilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switched:(id)sender {
//    BOOL f1 = [[self.view viewWithTag:1] isOn];
//    BOOL f2 = [[self.view viewWithTag:2] isOn];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"filterUpdate" object:nil];
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
