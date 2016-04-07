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
@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;
@property (nonatomic) NSUInteger data;
@property (strong, nonatomic) DataErrorView *errorView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *interactableViews;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak,nonatomic) UITextField *activeField;

@property (strong,nonatomic) NSMutableArray *textFieldsArray;
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
//    self.containerScrollView.contentInset = UIEdgeInsetsMake(0, 0, 90, 0);
    
}
- (IBAction)testButton:(id)sender {
    NSLog(@"unregister");
    [self unregisterForKeyboardNotifications];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    [self addTextFieldsToArray];
    self.manufacturerTextField.hidden = YES;
    self.yearTextField.hidden = YES;
    self.modelTextField.hidden = YES;
    self.licenseTextField.hidden = YES;
    self.colorTextField.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self unregisterForKeyboardNotifications];
}
- (void)viewDidAppear:(BOOL)animated {
    [self.containerScrollView setContentSize:self.containerScrollView.bounds.size];
    self.data = 0;
    [self closeErrorView:YES];
    [self shiftLabes];
    [self animateLabels];
}

#pragma mark - animation

- (void)shiftLabes {
    CGRect rect = self.yearTextField.frame;
    
    rect.origin.x -= self.view.bounds.size.width;
    [self.yearTextField setFrame:rect];
    
    rect = self.modelTextField.frame;
    rect.origin.x -= self.view.bounds.size.width;
    [self.modelTextField setFrame:rect];
    
    rect = self.manufacturerTextField.frame;
    rect.origin.x -= self.view.bounds.size.width;
    [self.manufacturerTextField setFrame:rect];
    
    rect = self.colorTextField.frame;
    rect.origin.x -= self.view.bounds.size.width;
    [self.colorTextField setFrame:rect];
    
    
    rect = self.licenseTextField.frame;
    rect.origin.x -= self.view.bounds.size.width;
    [self.licenseTextField setFrame:rect];
}
- (void)animateLabels {
    CGFloat delay = 0.0f;
    self.manufacturerTextField.hidden = NO;
    self.yearTextField.hidden = NO;
    self.modelTextField.hidden = NO;
    self.licenseTextField.hidden = NO;
    self.colorTextField.hidden = NO;
    [UIView animateKeyframesWithDuration:0.5 delay:delay options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^ {
        CGRect rect = self.licenseTextField.frame;
        rect.origin.x += self.view.bounds.size.width;
        [self.licenseTextField setFrame:rect];
        
    }completion:nil];
    delay += 0.2;
    [UIView animateKeyframesWithDuration:0.5 delay:delay options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^ {
        CGRect rect = self.colorTextField.frame;
        rect.origin.x += self.view.bounds.size.width;
        [self.colorTextField setFrame:rect];
        
    }completion:nil];
    delay += 0.2;
    
    
    [UIView animateKeyframesWithDuration:0.5 delay:delay options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^ {
        CGRect rect = self.manufacturerTextField.frame;
        rect.origin.x += self.view.bounds.size.width;
        [self.manufacturerTextField setFrame:rect];
        
    }completion:nil];
    delay += 0.2;
    
    
    [UIView animateKeyframesWithDuration:0.5 delay:delay options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^ {
        CGRect rect = self.modelTextField.frame;
        rect.origin.x += self.view.bounds.size.width;
        [self.modelTextField setFrame:rect];
        
    }completion:nil];
    delay += 0.2;
    
    [UIView animateKeyframesWithDuration:0.5 delay:delay options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^ {
        CGRect rect = self.yearTextField.frame;
        rect.origin.x += self.view.bounds.size.width;
        [self.yearTextField setFrame:rect];
        
    }completion:nil];
}
- (DataErrorView *)errorView {
       if( !_errorView) {
        _errorView = [[[NSBundle mainBundle] loadNibNamed:@"DataErrorView" owner:nil options:nil] lastObject];
        if ([_errorView isKindOfClass:[DataErrorView class]]) {
            [self.view addSubview:_errorView];
            [_errorView setFrame:self.view.frame];
            _errorView.delegate = self;
        } else {
            return nil;
        }
    }
    return _errorView;
}
#pragma mark - URLrequests
- (void)getInfoFromTextFields {
    
    NSString *tempLicense = self.licenseTextField.text;
    NSString *tempColor = self.colorTextField.text;
    NSString *tempManufacturer = self.manufacturerTextField.text;
    NSString *tempModel = self.modelTextField.text;
    NSString *tempYear = self.yearTextField.text;
    [[WebServiceManager manager] fetchImageInfoForManufacturer:tempManufacturer
                                                         model:tempModel
                                                         color:tempColor
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
        
        Vehicle* v = [[Vehicle alloc] initWithPlateLicense:tempLicense
                                                     color:tempColor
                                              manufacturer:tempManufacturer
                                                     model:tempModel
                                                      year:@([tempYear integerValue])
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

#pragma mark - gestures
- (IBAction)userDidTapBackground:(id)sender {
    [self.containerView endEditing:YES];
}

#pragma mark - IBActions

- (IBAction)clickParkingButton:(id)sender {

    if ([self isDataValid]) {
        
        [self getInfoFromTextFields];
        [self userDidTapBackground:nil];
        [self resetTextFields];
        
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
}
- (void)enableViews {
    for (UIView *view in self.interactableViews) {
        [view setUserInteractionEnabled:YES];
    }
}

#pragma mark - keyboard
- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
 
}
- (void)unregisterForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
   // [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
    
}
// Called when the UIKeyboardDidShowNotification is sent.

- (void)keyboardWasShown:(NSNotification*)aNotification

{
    
    NSDictionary* info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    
    self.containerScrollView.contentInset = contentInsets;
    
    self.containerScrollView.scrollIndicatorInsets = contentInsets;
    
    
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    
    // Your app might not need or want this behavior.
    
    CGRect aRect = self.view.frame;
    
    aRect.size.height -= kbSize.height;
    
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        
        [self.containerScrollView scrollRectToVisible:self.activeField.frame animated:YES];
        
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    self.activeField = textField;
    
}



- (void)textFieldDidEndEditing:(UITextField *)textField

{
    
    self.activeField = nil;
    
}


// Called when the UIKeyboardWillHideNotification is sent

- (void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    self.containerScrollView.contentInset = contentInsets;
    
    self.containerScrollView.scrollIndicatorInsets = contentInsets;
    
}
#pragma mark - accessors
- (NSMutableArray *)textFieldsArray {
    if (!_textFieldsArray) {
        _textFieldsArray = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return _textFieldsArray;
}
#pragma mark - text fields
- (void)resetTextFields {
    for (UITextField *textField in self.textFieldsArray) {
        if ([textField isKindOfClass:[UITextField class]]) {
            textField.text = @"";
        }
    }
}
- (void)addTextFieldsToArray {
    [self.textFieldsArray addObject:self.licenseTextField];
    [self.textFieldsArray addObject:self.colorTextField];
    [self.textFieldsArray addObject:self.manufacturerTextField];
    [self.textFieldsArray addObject:self.modelTextField];
    [self.textFieldsArray addObject:self.yearTextField];
    [self setTextFieldDelegates];
}
- (void)setTextFieldDelegates {
    for (UITextField *textField in self.textFieldsArray) {
        if ([textField isKindOfClass:[UITextField class]]) {
            textField.delegate = self;
        }
    }
}
- (NSUInteger)getActiveTextFieldIndex {
    
    UITextField *tempField = self.activeField;
    
    for (NSUInteger i = 0 ; i < [self.textFieldsArray count]; i += 1) {
        if (tempField == [self.textFieldsArray objectAtIndex:i]) {
            return i;
        }
    }
    //
    return NSUIntegerMax;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSUInteger index = [self getActiveTextFieldIndex];
    if (index < [self.textFieldsArray count]-1) {
        [[self.textFieldsArray objectAtIndex:(index+1)] becomeFirstResponder];
        
        self.activeField = [self.textFieldsArray objectAtIndex:(index+1)];
        
    } else if (index == [self.textFieldsArray count]-1) {
       // self.activeField = [self.textFieldsArray objectAtIndex:(index)];
        //[self.activeField resignFirstResponder];
        [self userDidTapBackground:nil];
        [self clickParkingButton:nil];
    } else {
        NSLog(@"text field not added in the array!");
        
    }
    
    return NO;
}

@end
