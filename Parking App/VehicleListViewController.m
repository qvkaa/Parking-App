//
//  VehicleListViewController.m
//  Parking App
//
//  Created by Yavor Aleksiev on 1/28/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "VehicleListViewController.h"
#import "Vehicle.h"
#import "ParkingLot.h"
#import "CustomTableViewCell.h"

static  NSString *EDIT_TOGGLED_OFF_TITLE = @"Edit";
static  NSString *EDIT_TOGGLED_ON_TITLE = @"Back";
@interface VehicleListViewController() <UITableViewDataSource, UITableViewDelegate>

#pragma mark - UIButton
@property (weak, nonatomic) IBOutlet UIButton *deleteSelectedButton;

@property (weak, nonatomic) IBOutlet UIButton *enterEditModeButton;

#pragma mark - BOOL
@property (assign) BOOL isEditButtonToggledOn;


#pragma mark - UITableView
@property (nonatomic, strong) IBOutlet UITableView *tableView;
//@property (nonatomic, strong) UIImageView *imageView;

//- (void)centerScrollViewContents;
//- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
//- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;
@end

@implementation VehicleListViewController

#pragma mark - Lifecycle

//- (void)viewDidAppear:(BOOL)animated {
//    self.isEditButtonToggledOn = NO;
//    [self.enterEditModeButton setTitle:EDIT_TOGGLED_OFF_TITLE forState:UIControlStateNormal];
//    [self.tableView setEditing:NO];
//    self.deleteSelectedButton.hidden = YES;
//}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.isEditButtonToggledOn = NO;
    [self.enterEditModeButton setTitle:EDIT_TOGGLED_OFF_TITLE forState:UIControlStateNormal];
    [self.tableView setEditing:NO];
    self.deleteSelectedButton.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"xibCell"];
    [self.tableView reloadData];
   // [self.tableView setRowHeight:125.0];
    //[self.tableView setEstimatedRowHeight:400.0];
    [self.tableView setAllowsMultipleSelectionDuringEditing:YES];
    [self.enterEditModeButton setTitle:EDIT_TOGGLED_OFF_TITLE forState:UIControlStateNormal];
    self.deleteSelectedButton.hidden = YES;
//    AppDelegate* delegate = [[UIApplication sharedApplication] delegate ];
//    NSUInteger totalVehicles = [delegate.vehicles count];
//    NSUInteger labelHeight = totalVehicles * NUMBER_OF_LINES * DEFAULT_HEIGHT;
//    NSUInteger labelSpacing = (totalVehicles+1) * DEFAULT_SPACING_HEIGHT;
//    NSUInteger contentHeight = labelHeight + labelSpacing;
//    CGFloat contentWidth = CGRectGetWidth(self.view.frame);
//    NSLog(@"count %ld", [delegate.vehicles count]);
//    NSLog(@"height : %ld  width : %f", contentHeight, contentWidth);
////    self.scrollView.contentSize=CGSizeMake(contentWidth, contentHeight);
//    NSInteger verticalSpacing= 0;
//    
//  //  NSMutableArray *labelViews = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i < totalVehicles; i++)
//    {
//        UILabel *label =  [[UILabel alloc] initWithFrame:CGRectMake(40,verticalSpacing,contentWidth,NUMBER_OF_LINES * DEFAULT_HEIGHT)];
//        label.lineBreakMode = 0;
//        label.numberOfLines = NUMBER_OF_LINES;
//        label.text = [ ((Vehicle *)[delegate.vehicles objectAtIndex:i]) vehicleInfo];
////        [self.scrollView addSubview:label];
//        NSNumber *number = [NSNumber numberWithLong:verticalSpacing];
//        NSDictionary *metrics = @{@"spacing":number};
//        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
//        NSDictionary *views = NSDictionaryOfVariableBindings(label);
////        NSArray *horizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[label]-40-|" options:0 metrics:nil views:views];
////        NSArray *verticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-spacing-[label]" options:0 metrics:metrics views:views];
////        [self.scrollView addConstraint:horizontalConstraints[0]];
////        [self.scrollView addConstraint:verticalConstraints[0]];
//        verticalSpacing += DEFAULT_SPACING_HEIGHT + ( NUMBER_OF_LINES * DEFAULT_HEIGHT);
//    }

}
#pragma mark - IBAction
- (IBAction)enterEditModeAction:(id)sender {
    if ( self.isEditButtonToggledOn) {
        self.isEditButtonToggledOn = NO;
        [sender setTitle:EDIT_TOGGLED_OFF_TITLE forState:UIControlStateNormal];
        [self.tableView setEditing:NO];
        self.deleteSelectedButton.hidden = YES;
        
    } else {
        self.isEditButtonToggledOn = YES;
        [sender setTitle:EDIT_TOGGLED_ON_TITLE forState:UIControlStateNormal];
        [self.tableView setEditing:YES];
        self.deleteSelectedButton.hidden = NO;
    }
  }
- (IBAction)deleteSelectedAction:(id)sender {
    ParkingLot *parking = [ParkingLot defaultParking];
    NSArray *rowIndices = [self.tableView.indexPathsForSelectedRows mutableCopy];
    rowIndices = [rowIndices sortedArrayUsingComparator: ^(id obj1, id obj2) {
        NSIndexPath *object1 = obj1;
        NSIndexPath *object2 = obj2;
        if (object1.row > object2.row) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        if (object1.row < object2.row) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
        return (NSComparisonResult)NSOrderedSame;
        
    }];
    for (NSIndexPath *indexPath in rowIndices) {
        [parking removeVehicleAtIndex:indexPath.row];
    }
    [self.tableView reloadData];
    [parking saveData];
}

#pragma mark - Delegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 125.0;
  //  ParkingLot *parking = [ParkingLot defaultParking];
    
    
    return height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    ParkingLot *parking = [ParkingLot defaultParking];
    NSUInteger numberOfVehicles = [parking totalVehicles];
    return numberOfVehicles;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ParkingLot *parking = [ParkingLot defaultParking];
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"xibCell" forIndexPath:indexPath];
    [cell.vehicleInfoLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    cell.vehicleInfoLabel.text = [[parking vehicleAtIndex:indexPath.row] vehicleInfo];
   
    if ([[parking vehicleAtIndex:indexPath.row].flickrImage imageURL] == nil ) {
        cell.vehiclePicture.image = [UIImage imageNamed:@"defaultCar"];
    } else {
        NSURL *url = [[parking vehicleAtIndex:indexPath.row].flickrImage imageURL];
        NSData *dataURL = [NSData dataWithContentsOfURL:url];
        cell.vehiclePicture.image = [UIImage imageWithData:dataURL];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}



//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        ParkingLot *parking = [ParkingLot defaultParking];
//        [parking removeVehicleAtIndex:indexPath.row];
//        NSLog(@"Deleting row %ld",indexPath.row);
//        [tableView reloadData];
//        [parking saveData]; 
//        
//    }
//}



@end
