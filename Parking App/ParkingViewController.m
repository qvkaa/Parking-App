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
#import "ParkingLot.h"

//
//static const NSInteger ERROR_VIEW_WIDTH = 300;
//static const NSInteger ERROR_VIEW_HEIGTH = 250;

@interface ParkingViewController()

#pragma mark - Property
@property (nonatomic) NSUInteger data;
@property (strong, nonatomic) DataErrorView *errorView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *interactableViews;

//@property (weak, nonatomic) IBOutlet UIView *errorView;
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
#pragma mark - Delegate Methods
- (void)closeErrorView:(BOOL)complete {
    if (complete) {
        [self enableViews];
        self.errorView.hidden = YES;
    }
}

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Parking";
    
 //   self.errorView.hidden = NO;
    
    
}

- (DataErrorView *)errorView {
    if( !_errorView) {
             //setting the view in the middle of the super class
//        CGFloat contentWidth = CGRectGetWidth(self.view.frame);
//        CGFloat contentHeigth = CGRectGetHeight(self.view.frame);
//        CGFloat x = contentWidth/2 - ERROR_VIEW_WIDTH/2;
//        CGFloat y = contentHeigth/2 - ERROR_VIEW_HEIGTH/2;
//        CGRect  viewRect = CGRectMake(x, y, ERROR_VIEW_WIDTH, ERROR_VIEW_HEIGTH);
        _errorView = [[[NSBundle mainBundle] loadNibNamed:@"DataErrorView" owner:nil options:nil] lastObject];
        if ([_errorView isKindOfClass:[DataErrorView class]]) {
            [self.view addSubview:self.errorView];
            [self.errorView setFrame:self.view.frame];
            self.errorView.delegate = self;
        } else {
            return nil;
        }

//        _errorView = [[DataErrorView alloc] init];
//        [self.view addSubview:self.errorView];
//        [self.errorView setFrame:viewRect];
    }
    return _errorView;
}
#pragma mark - Data Validation

- (void) setData:(NSUInteger)data {
    _data = _data | data;
}

- (BOOL) isDataValid {
    return (self.data == ValidAll) ? YES : NO;
}
- (NSString *)errorMessage {
    NSString *errorMessage = @"";
    if (! (self.data & ValidLicense)) { // check if bit is set
        
        errorMessage = [errorMessage stringByAppendingString:@"*License plate lenght must be between"
                        " 7 and 8 characters long!\n"];
    }
    if (!(self.data & ValidColor)) { // check if bit is set
        
        errorMessage = [errorMessage stringByAppendingString:@"*Invalid color!\n"];
    }
    if (!(self.data & ValidManufacturer)) { // check if bit is set
        
        errorMessage = [errorMessage stringByAppendingString:@"*Invalid manufacturer!\n"];
    }
    if (!(self.data & ValidModel)) { // check if bit is set
        
        errorMessage = [errorMessage stringByAppendingString:@"*Invalid model!\n"];
    }
    if (!(self.data & ValidYear)) { // check if bit is set
        
        errorMessage = [errorMessage stringByAppendingString:@"*Invalid year!\n"];
    }
    return errorMessage;
}

#pragma mark - Orientation
- (BOOL)shouldAutorotate
{
    return NO;
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - IBActions

- (IBAction)clickParkingButton:(id)sender {
    self.data = [ValidateDataUtil isValidYear:self.yearTextField.text];
    NSInteger length = 8;
    self.data = [ValidateDataUtil isValidLicense:self.licenseTextField.text requiredLength:length];
    length = 7;
    self.data = [ValidateDataUtil isValidLicense:self.licenseTextField.text requiredLength:length];
    self.data = [ValidateDataUtil isValidManufacturer:self.manufacturerTextField.text];
    self.data = [ValidateDataUtil isValidModel:self.modelTextField.text];
    self.data = [ValidateDataUtil isValidColor:self.colorTextField.text];
    if ([self isDataValid]) {
        NSLog(@"success");
    } else {
        NSLog(@"failure");
    }
    
    if ([self isDataValid]) {
          //  AppDelegate* delegate = [[UIApplication sharedApplication] delegate ];
            ParkingLot *parking = [ParkingLot defaultParking];
            Vehicle* v = [[Vehicle alloc]initWithPlateLicense:self.licenseTextField.text
                                                        color:self.colorTextField.text
                                                 manufacturer:self.manufacturerTextField.text
                                                        model:self.modelTextField.text
                                                         year:@([self.yearTextField.text integerValue])
                      ];
        [parking addVehicle:v];
        [parking saveData];

    } else {
        [self disableViews];
        self.errorView.hidden = NO;
        self.errorView.errorLabel.numberOfLines = 0;
        self.errorView.errorLabel.text = [self errorMessage];
    }
}
- (void)disableViews {
    for (UIView *view in self.interactableViews) {
        [view setUserInteractionEnabled:NO];
    }
   // [self.interactableViews makeObjectsPerformSelector:@selector(setUserInteractionEnabled:) withObject:@NO];
}
- (void)enableViews {
    for (UIView *view in self.interactableViews) {
        [view setUserInteractionEnabled:YES];
    }
    //[self.interactableViews makeObjectsPerformSelector:@selector(setUserInteractionEnabled:) withObject:@YES];
}
@end
