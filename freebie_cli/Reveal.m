//
//  Reveal.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 10/05/16.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "Reveal.h"

@interface Reveal ()

@end

@implementation Reveal

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"asd %@", segue.identifier);
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
