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
#import "NavigationControllerCoordinator.h"
#import "CustomGalleryCell.h"
static  NSString *EDIT_TOGGLED_OFF_TITLE = @"Edit";
static  NSString *EDIT_TOGGLED_ON_TITLE = @"Back";
@interface VehicleListViewController() 

@property (weak, nonatomic) IBOutlet UIButton *deleteSelectedButton;
@property (weak, nonatomic) IBOutlet UIButton *enterEditModeButton;
@property (nonatomic) BOOL tableViewModeOn;
@property (nonatomic) CGRect animationStartingFrame;
@property (strong,nonatomic) UIImageView *imageToBeAnimated;

@property (assign) BOOL isEditButtonToggledOn;

@property (nonatomic, strong) IBOutlet UITableView *tableView;


@property (strong, nonatomic) VehicleGalleryScrollView *galleryScrollView;
@property (nonatomic) NSInteger tableViewRow;
@property (nonatomic) CGRect originFrame;
@end

@implementation VehicleListViewController

#pragma mark - Lifecycle


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.isEditButtonToggledOn = NO;
    [self.enterEditModeButton setTitle:EDIT_TOGGLED_OFF_TITLE forState:UIControlStateNormal];
    [self.tableView setEditing:NO];
    self.deleteSelectedButton.hidden = YES;
}
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([sender isKindOfClass:[NSIndexPath class]]) {
//        NSIndexPath *path = sender;
//        NSInteger row = path.row;
//        CustomTableViewCell *cell = [self.tableView cellForRowAtIndexPath:sender];
//        //CGRect frame = cell.vehiclePicture.frame;
//        CGRect frame = [cell convertRect:cell.vehiclePicture.frame toView:self.view];
//        if ([[segue identifier] isEqualToString:@"openGallery"])
//        {
//            VehicleGalleryViewController *vc = [segue destinationViewController];
//            vc.tableViewRow = row;
//            vc.originFrame = frame;
//            self.imageToBeAnimated = cell.vehiclePicture;
//            vc.transitioningDelegate = self;
//
//        }
//    }
//    

    

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"xibCell"];
    [self.tableView reloadData];
    [self.tableView setAllowsMultipleSelectionDuringEditing:YES];
    [self.enterEditModeButton setTitle:EDIT_TOGGLED_OFF_TITLE forState:UIControlStateNormal];
    self.deleteSelectedButton.hidden = YES;
    self.tableViewModeOn = YES;
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
        [self disableViews];
        self.tableViewRow = indexPath.row;
        
        CustomTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        self.imageToBeAnimated = cell.vehiclePicture;
        
        CGRect rect = cell.vehiclePicture.frame;
        rect.origin = [cell convertPoint:rect.origin toView:nil];
        self.originFrame = rect;
        self.galleryScrollView = nil;
        self.galleryScrollView = [[VehicleGalleryScrollView alloc] initWithFrame:self.view.frame];
        self.galleryScrollView.galleryDelegate = self;
        [self.view addSubview:self.galleryScrollView];
        self.tableViewModeOn = YES;
        [self animateSwitchBetweenModes];

    }
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}


#pragma mark - gallery scroll view delegate methods
- (GalleryCell *)galleryScrollView:(VehicleGalleryScrollView *)scrollView cellForCollumAtIndex:(NSUInteger)index {
    ParkingLot *parking = [ParkingLot defaultParking];
    CustomGalleryCell *cell = (CustomGalleryCell *)[scrollView dequeueReusableCellWithIdentifier:@"GalleryCell"];
    
    cell.galleryImage.image = [UIImage imageNamed:@"defaultCar"];
    NSInteger totalImages =  [[parking vehicleAtIndex:self.tableViewRow].flickrImages count];
    if ( totalImages < 1) { // no images for that vehicle
        return cell;
    }
    NSInteger cellIndex = index;
    while (cellIndex < 0) {
        cellIndex += totalImages;
    }
    cellIndex %= totalImages;
    
    if ([[[parking vehicleAtIndex:self.tableViewRow].flickrImages objectAtIndex:cellIndex] imageURL]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[[[parking vehicleAtIndex:self.tableViewRow].flickrImages objectAtIndex:cellIndex] imageURLWithImageSize:ImageSizeDefault]];
        [cell.galleryImage setImageWithURLRequest:request
                                 placeholderImage:nil
                                          success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                              cell.galleryImage.image = image;
                                              [cell.galleryImage setBackgroundColor:[UIColor clearColor]];
                                          }
                                          failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                              NSLog(@"%@",[error description]);
                                              cell.galleryImage.image = [UIImage imageNamed:@"defaultCar"];
                                          }];
    }
    return cell;
    
}
- (void)userDidTap {
    [self enableViews];
    self.tableViewModeOn = NO;
    [self animateSwitchBetweenModes];
}
//- (void)galleryScrollView:(VehicleGalleryScrollView *)scrollView currentCellIndex:(NSInteger)index {
//   // NSString *title = [NSString stringWithFormat:@"Image %ld / %ld",index+1,[self numberOfGalleryCells]];
//    //self.navigationBar.title = title;
//}
- (NSInteger)numberOfGalleryCells {
    ParkingLot *parking = [ParkingLot defaultParking];
    NSInteger totalImages =  [[parking vehicleAtIndex:self.tableViewRow].flickrImages count];
    return totalImages;
}
#pragma mark - private methods
- (void)disableViews {
    self.tableView.userInteractionEnabled = NO;
    self.deleteSelectedButton.enabled = NO;
    self.editButtonItem.enabled = NO;
    // [self.interactableViews makeObjectsPerformSelector:@selector(setUserInteractionEnabled:) withObject:@NO];
}
- (void)enableViews {
    self.tableView.userInteractionEnabled = YES;
    self.deleteSelectedButton.enabled = YES;
    self.editButtonItem.enabled = YES;
    //[self.interactableViews makeObjectsPerformSelector:@selector(setUserInteractionEnabled:) withObject:@YES];
}

#pragma mark - animation 
- (void)animateSwitchBetweenModes {
    //UIView *containerView = [transitionContext containerView];
    //VehicleGalleryViewController *toController = (VehicleGalleryViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey ];
   // toController.galleryScrollView.backgroundColor = [UIColor whiteColor];
    
    UIView *toView;
//    if (self.tableViewModeOn) {
        toView = self.galleryScrollView;
//    } else {
//        CustomGalleryCell *tempCell = (CustomGalleryCell*)[self.galleryScrollView currentVisibleView];
//        toView = tempCell.galleryImage;
//    }
    UIView *fromView;
    //VehicleListViewController *fromController;
    
    
    
    //fromController = (VehicleListViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    fromView = toView;
    
    CGRect initialFrame;
    if (self.tableViewModeOn) {
        initialFrame = self.originFrame;
    } else {
        initialFrame = fromView.frame;
        
    }
    
    CGRect finalFrame;
    if (self.tableViewModeOn) {
        finalFrame = fromView.frame;
        CGFloat xScaleFactor = (finalFrame.size.width / initialFrame.size.width);
        CGFloat prevHeight = initialFrame.size.height;
        initialFrame.size.width = finalFrame.size.width / xScaleFactor;
        initialFrame.size.height = finalFrame.size.height / xScaleFactor;
        CGFloat currentHeight = initialFrame.size.height;
        CGFloat newY = (currentHeight - prevHeight) / 2;
        initialFrame.origin.y -=    newY;
       // fromView.backgroundColor = [UIColor clearColor];
      //  toController.galleryScrollView.backgroundColor = [UIColor whiteColor];
    } else {
        CGRect tempRect = self.originFrame;
        CGFloat xScale = (initialFrame.size.width / tempRect.size.width);
        tempRect.size.height = initialFrame.size.height / xScale;
        tempRect.size.width = initialFrame.size.width / xScale;
        CGFloat yDifference = (tempRect.size.height - self.originFrame.size.height)/2;
        tempRect.origin.y -= yDifference;
        finalFrame = tempRect;
        
    }
    
    
    CGFloat xScaleFactor;
    if (self.tableViewModeOn) {
        xScaleFactor = (initialFrame.size.width / finalFrame.size.width);
    } else {
        xScaleFactor = (finalFrame.size.width / initialFrame.size.width);
    }
    CGFloat yScaleFactor;
    if (self.tableViewModeOn) {
        yScaleFactor =  (initialFrame.size.height) / (finalFrame.size.height);
    } else {
        yScaleFactor = (finalFrame.size.height) / (initialFrame.size.height);
    }
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
    
    if (self.tableViewModeOn) {
        fromView.transform = scaleTransform;
        fromView.center = CGPointMake(CGRectGetMidX(initialFrame),CGRectGetMidY(initialFrame));
        fromView.clipsToBounds = YES;
        //  [fromController.navigationController pushViewController:toController animated:NO];
    }
    
  
    CGFloat duration = 1;
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
        fromView.transform  = self.tableViewModeOn ? CGAffineTransformIdentity : scaleTransform;
        fromView.center = CGPointMake(CGRectGetMidX(finalFrame),CGRectGetMidY(finalFrame));
        if (self.tableViewModeOn) {
            self.galleryScrollView.backgroundColor = [UIColor blackColor];
        } else {
            self.galleryScrollView.backgroundColor = [UIColor clearColor];
        }
    } completion: ^(BOOL finished ){
        if (!self.tableViewModeOn) {
            self.galleryScrollView.hidden = YES;
        }
    }];
    
}

@end
