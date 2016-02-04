//
//  ViewController.h
//  Parking App
//
//  Created by Yavor Aleksiev on 1/25/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)goToParking:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ParkingButton;

@property (weak, nonatomic) IBOutlet UILabel *MainTextLabel;


@end

