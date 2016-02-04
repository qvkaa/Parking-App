//
//  VehicleListViewController.m
//  Parking App
//
//  Created by Yavor Aleksiev on 1/28/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "VehicleListViewController.h"
#import "AppDelegate.h"
#import "Vehicle.h"

static const NSInteger DEFAULT_HEIGHT = 21;
static const NSInteger DEFAULT_SPACING_HEIGHT = 10;
static const NSInteger NUMBER_OF_LINES = 5;

@interface VehicleListViewController()

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
//@property (nonatomic, strong) UIImageView *imageView;

//- (void)centerScrollViewContents;
//- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
//- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;
@end
@implementation VehicleListViewController
@synthesize scrollView = _scrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate ];
    NSUInteger totalVehicles = [delegate.vehicles count];
    NSUInteger labelHeight = totalVehicles * NUMBER_OF_LINES * DEFAULT_HEIGHT;
    NSUInteger labelSpacing = (totalVehicles+1) * DEFAULT_SPACING_HEIGHT;
    NSUInteger contentHeight = labelHeight + labelSpacing;
    CGFloat contentWidth = CGRectGetWidth(self.view.frame);
    NSLog(@"count %ld", [delegate.vehicles count]);
    NSLog(@"height : %ld  width : %f", contentHeight, contentWidth);
    self.scrollView.contentSize=CGSizeMake(contentWidth, contentHeight);
    NSInteger verticalSpacing= 0;
    
  //  NSMutableArray *labelViews = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < totalVehicles; i++)
    {
        UILabel *label =  [[UILabel alloc] initWithFrame:CGRectMake(40,verticalSpacing,contentWidth,NUMBER_OF_LINES * DEFAULT_HEIGHT)];
        label.lineBreakMode = 0;
        label.numberOfLines = NUMBER_OF_LINES;
        label.text = [ ((Vehicle *)[delegate.vehicles objectAtIndex:i]) vehicleInfo];
        [self.scrollView addSubview:label];
        NSNumber *number = [NSNumber numberWithLong:verticalSpacing];
        NSDictionary *metrics = @{@"spacing":number};
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSDictionary *views = NSDictionaryOfVariableBindings(label);
        NSArray *horizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[label]-40-|" options:0 metrics:nil views:views];
        NSArray *verticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-spacing-[label]" options:0 metrics:metrics views:views];
        [self.scrollView addConstraint:horizontalConstraints[0]];
        [self.scrollView addConstraint:verticalConstraints[0]];
        verticalSpacing += DEFAULT_SPACING_HEIGHT + ( NUMBER_OF_LINES * DEFAULT_HEIGHT);
    }
}

@end
