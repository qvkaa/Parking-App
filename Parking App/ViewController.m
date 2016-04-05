//
//  ViewController.m
//  Parking App
//
//  Created by Yavor Aleksiev on 1/25/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "ViewController.h"
#import "Vehicle.h"
#import "AppDelegate.h"
#import "ParkingLot.h"
//#import "SecondViewController.h"

@interface ViewController ()
//- (IBAction)goToParking:(id)sender;
//@property (weak, nonatomic) IBOutlet UIButton *parkingButton;

@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;

@end

@implementation ViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.mainTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ParkingLot *parking = [ParkingLot defaultParking];
    self.navigationItem.title = @"Total Vehicles";
    self.mainTextLabel.text = [NSString stringWithFormat: @"Parked Vehicles : %ld", [parking totalVehicles]];
    self.mainTextLabel.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGRect rect = self.mainTextLabel.frame;
    rect.origin.x -= self.view.bounds.size.width;
    [self.mainTextLabel setFrame:rect];
    self.mainTextLabel.hidden = NO;
    [UIView animateWithDuration:0.5 animations: ^{
        CGRect rect = self.mainTextLabel.frame;
        rect.origin.x += self.view.bounds.size.width;
        [self.mainTextLabel setFrame:rect];
    }];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
