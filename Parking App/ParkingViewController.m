//
//  ParkingViewController.m
//  Parking App
//
//  Created by Yavor Aleksiev on 1/26/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "ParkingViewController.h"
#import "ValidateDataUtil.h"
#import "AppDelegate.h"
#import "Vehicle.h"
@interface ParkingViewController()
#pragma mark - IBActions

- (IBAction)clickParkingButton:(id)sender;

#pragma mark - NSButton

@property (weak, nonatomic) IBOutlet UIButton *parkVehicleButton;

#pragma mark - UILabel

@property (weak, nonatomic) IBOutlet UILabel *parkingGeneralLabel;

#pragma mark - UITextField;

@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UITextField *manufacturerTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;
@property (weak, nonatomic) IBOutlet UITextField *licenseTextField;
@end
@implementation ParkingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Parking";
}
- (IBAction)clickParkingButton:(id)sender {
    BOOL isYearValid = YES;
    BOOL isLicenseValid = YES;
    isYearValid = [ValidateDataUtil isValidYear:_yearTextField.text];
    NSInteger len = 8;
    isLicenseValid = [ValidateDataUtil isValidLength:_licenseTextField.text requiredLength:&len];
    if(isYearValid && isLicenseValid && [self.modelTextField.text length] > 0
       && [self.manufacturerTextField.text length] > 0 && [self.colorTextField.text length] > 0) {
        NSLog(@"success");
    } else {
        NSLog(@"failure");
    }
    
    if (isLicenseValid && isYearValid) { // && [self.modelTextField.text length] > 0
    //   && [self.manufacturerTextField.text length] > 0 && [self.colorTextField.text length] > 0) {
        AppDelegate* delegate = [[UIApplication sharedApplication] delegate ];
        Vehicle* v = [[Vehicle alloc]initWithPlateLicense:self.licenseTextField.text
                                                   color:self.colorTextField.text
                                             manufacturer:self.manufacturerTextField.text
                                                    model:self.modelTextField.text
                                                     year:@([self.yearTextField.text integerValue])
                      ];
        [delegate.vehicles addObject:v];
        NSLog(@"count : %ld",[delegate.vehicles count]);
        //NSLog(@"%ld",[Vehicle totalParkedVehicles]);
        NSLog(@"%@",[v vehicleInfo]);
    }
}
@end
