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

#import "WebServiceManager.h"

@interface ParkingViewController()

#pragma mark - Property
@property (nonatomic) NSUInteger data;
@property (strong, nonatomic) DataErrorView *errorView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *interactableViews;

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
- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"Parking";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.data = 0;
    [self closeErrorView:YES];
}

- (DataErrorView *)errorView {
    if( !_errorView) {
        _errorView = [[[NSBundle mainBundle] loadNibNamed:@"DataErrorView" owner:nil options:nil] lastObject];
        if ([_errorView isKindOfClass:[DataErrorView class]]) {
            [self.view addSubview:self.errorView];
            [self.errorView setFrame:self.view.frame];
            self.errorView.delegate = self;
        } else {
            return nil;
        }
    }
    return _errorView;
}
#pragma mark - URLrequests
- (void)getInfoFromTextFields {
    
    
    [[WebServiceManager manager] fetchImageInfoForManufacturer:self.manufacturerTextField.text
                                                         model:self.modelTextField.text
                                                         color:self.colorTextField.text
                                           withCompletionBlock:^(NSArray *array) {
                            
        NSMutableArray *photos = [[NSMutableArray alloc] initWithCapacity:[array count]];  // of FlickrImage
            for (NSUInteger index = 0 ; index < [array count] ; ++index   ) {
            NSDictionary *photo = [array objectAtIndex:index];
          
            NSString *farmID = [photo objectForKey:@"farm"];
            NSString *imageID = [photo objectForKey:@"id"];
            NSString *server = [photo objectForKey:@"server"];
            NSString *secret = [photo objectForKey:@"secret"];
            FlickrImage *image;
            if (photo) {
                image = [[FlickrImage alloc] initWithImageID:imageID farmID:farmID server:server secret:secret];
            } else {
                image = nil;
            }
            [photos addObject:image];

        }
        
        Vehicle* v = [[Vehicle alloc] initWithPlateLicense:self.licenseTextField.text
                                                     color:self.colorTextField.text
                                              manufacturer:self.manufacturerTextField.text
                                                     model:self.modelTextField.text
                                                      year:@([self.yearTextField.text integerValue])
                                                     images: photos];
        
        ParkingLot *parking = [ParkingLot defaultParking];
        [parking addVehicle:v];
        [parking saveData];
    }];
}

#pragma mark - Data Validation

- (void) setData:(NSUInteger)data {
    if (data == -1) {
        _data = 0;
    } else {
        _data = _data | data;
    }
}

- (BOOL) isDataValid {
    
   
    self.data = -1;
    self.data = [ValidateDataUtil isValidYear:self.yearTextField.text];
    NSInteger length = 8;
    self.data = [ValidateDataUtil isValidLicense:self.licenseTextField.text requiredLength:length];
    length = 7;
    self.data = [ValidateDataUtil isValidLicense:self.licenseTextField.text requiredLength:length];
    self.data = [ValidateDataUtil isValidManufacturer:self.manufacturerTextField.text];
    self.data = [ValidateDataUtil isValidModel:self.modelTextField.text];
    self.data = [ValidateDataUtil isValidColor:self.colorTextField.text];
   

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

    if ([self isDataValid]) {
        [self getInfoFromTextFields];
        
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
