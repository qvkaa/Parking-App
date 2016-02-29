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
    
    //[self.MainButton setTitle:@"Park Now" forState:UIControlStateNormal];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ParkingLot *parking = [ParkingLot defaultParking];
    self.navigationItem.title = @"Total Vehicles";
    self.mainTextLabel.text = [NSString stringWithFormat: @"Parked Vehicles : %ld", [parking totalVehicles]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)handleMainButtonClick:(id)sender {
//    /*AppDelegate* delegate = [[UIApplication sharedApplication] delegate ];
//    Vehicle* v = [[Vehicle alloc]initWithPlateLicense:@"asd"
//                                               colour:@"red"
//                                         manufacturer:@"renault"
//                                                model:@"model"
//                                                 year:@12];
//
//    [delegate.vehicles addObject:v];
//    NSLog(@"%ld",[Vehicle totalParkedVehicles]);
//     */
//  //  [firstViewController presentModalViewController:secondViewController animated:YES];
//  //  SecondViewController *second = [[SecondViewController alloc] initWithNibName:nil bundle:nil ];
//  //  [self presentViewController:second animated:YES completion:NULL];
//    }
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//}
//
//- (IBAction)goToParking:(id)sender {
//    [self performSegueWithIdentifier:@"SegueToNextPage" sender:self];
//}
@end
