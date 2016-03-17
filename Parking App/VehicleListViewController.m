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
#import "UIImageView+AFNetworking.h"
#import "VehicleGalleryViewController.h"
#import "AnimationController.h"
static  NSString *EDIT_TOGGLED_OFF_TITLE = @"Edit";
static  NSString *EDIT_TOGGLED_ON_TITLE = @"Back";
@interface VehicleListViewController() 

@property (weak, nonatomic) IBOutlet UIButton *deleteSelectedButton;
@property (weak, nonatomic) IBOutlet UIButton *enterEditModeButton;

@property (strong, nonatomic) AnimationController *transition;

@property (assign) BOOL isEditButtonToggledOn;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation VehicleListViewController
#pragma mark - accessors
- (AnimationController *)transition {
    if (!_transition) {
        _transition = [[AnimationController alloc] init];
    }
    return _transition;
}
#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.isEditButtonToggledOn = NO;
    [self.enterEditModeButton setTitle:EDIT_TOGGLED_OFF_TITLE forState:UIControlStateNormal];
    [self.tableView setEditing:NO];
    self.deleteSelectedButton.hidden = YES;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        NSIndexPath *path = sender;
        NSInteger row = path.row;
        
        if ([[segue identifier] isEqualToString:@"openGallery"])
        {
            // Get reference to the destination view controller
            //VehicleGalleryViewController  *vc = [segue destinationViewController];
//            VehicleGalleryViewController *vc = (VehicleGalleryViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"VehicleGalleryViewController"];// as! HerbDetailsViewController
//            // Pass any objects to the view controller here, like...
//            NSIndexPath *path = sender;
//            NSInteger row = path.row;
//            vc.tableViewRow = row;
//            vc.transitioningDelegate = self;
//            [self presentViewController:vc animated:YES completion:nil];
            
          //  presentViewController(herbDetails, animated: true, completion: nil)
        }
    }
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"xibCell"];
    [self.tableView reloadData];
    [self.tableView setAllowsMultipleSelectionDuringEditing:YES];
    [self.enterEditModeButton setTitle:EDIT_TOGGLED_OFF_TITLE forState:UIControlStateNormal];
    self.deleteSelectedButton.hidden = YES;
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

#pragma mark -  tableview delegate methods
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParkingLot *parking = [ParkingLot defaultParking];
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"xibCell" forIndexPath:indexPath];
    [cell.vehicleInfoLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    cell.vehicleInfoLabel.text = [[parking vehicleAtIndex:indexPath.row] vehicleInfo];
    cell.vehiclePicture.image = [UIImage imageNamed:@"defaultCar"];
    [cell.pictureLoadingIndicator stopAnimating];
    [cell.pictureLoadingIndicator setHidden:YES];
    if ( [[parking vehicleAtIndex:indexPath.row].flickrImages count] < 1) {
        return cell;
    }
    
    if ([[[parking vehicleAtIndex:indexPath.row].flickrImages objectAtIndex:0] imageURL]) {
        [cell.vehiclePicture setHidden:YES];
        [cell.pictureLoadingIndicator startAnimating];
        [cell.pictureLoadingIndicator setHidden:NO];
        NSURLRequest *request = [NSURLRequest requestWithURL:[[[parking vehicleAtIndex:indexPath.row].flickrImages objectAtIndex:0] imageURLWithImageSize:ImageSizeDefault]];
        [cell.vehiclePicture setImageWithURLRequest:request
    placeholderImage:nil
    success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        cell.vehiclePicture.image = image;
        [cell.pictureLoadingIndicator stopAnimating];
        cell.pictureLoadingIndicator.hidden = YES;
        cell.vehiclePicture.hidden = NO;
        cell.vehiclePicture.userInteractionEnabled = YES;
    }
    failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        NSLog(@"%@",[error description]);
        cell.vehiclePicture.image = [UIImage imageNamed:@"defaultCar"];
        [cell.pictureLoadingIndicator stopAnimating];
        [cell.pictureLoadingIndicator setHidden:YES];
        [cell.vehiclePicture setHidden:NO];
    }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.tableView.editing) {
    
        NSInteger row = indexPath.row;
        VehicleGalleryViewController *vc = (VehicleGalleryViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"VehicleGalleryViewController"];
        
        vc.tableViewRow = row;
        vc.transitioningDelegate = self;
        [self presentViewController:vc animated:YES completion:nil];

        //[self performSegueWithIdentifier:@"openGallery" sender:indexPath];
    }
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

#pragma mark - presentationControllerForPresentedViewController delegate methods

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source {
    return self.transition;
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return nil;
}
#pragma mark - animation
//- (id)animationControllerForPresentedController:(UIViewController *)presented
//                           presentingController:(UIViewController *)presenting
//                               sourceController:(UIViewController *)source
//{
//    self.animationController.isPresenting = YES;
//    
//    return self.animationController;
//}
//
//- (id )animationControllerForDismissedController:(UIViewController *)dismissed {
//    self.animationController.isPresenting = NO;
//    
//    return self.animationController;
//}
@end
