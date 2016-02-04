//
//  SecondViewController.m
//  Parking App
//
//  Created by Yavor Aleksiev on 1/26/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.MainButton setTitle:@"Park Now" forState:UIControlStateNormal];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // self.MainTextLabel.text = [NSString stringWithFormat: @"Parked Vehicles : %ld", (long)[Vehicle totalParkedVehicles]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
