//
//  DataValidateView.h
//  Parking App
//
//  Created by yavoraleksiev on 2/9/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataValidateView : UIView

@property (strong, nonatomic) IBOutlet DataValidateView *myView;

- (IBAction)errorButtonConfirmation:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end
