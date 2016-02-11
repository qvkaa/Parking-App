//
//  ErrorContainerViewController.m
//  Parking App
//
//  Created by yavoraleksiev on 2/11/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "ErrorContainerViewController.h"
#import "DataErrorView.h"
@interface ErrorContainerViewController ()

@end

@implementation ErrorContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DataErrorView  *nibView = [[DataErrorView alloc] init];
    
    [self.view addSubview:nibView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
