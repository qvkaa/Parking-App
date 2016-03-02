//
//  VehicleGalleryViewController.m
//  Parking App
//
//  Created by yavoraleksiev on 2/29/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "VehicleGalleryViewController.h"

@interface VehicleGalleryViewController ()
@property (strong, nonatomic) IBOutlet VehicleGalleryScrollView *galleryScrollView;

@end

@implementation VehicleGalleryViewController
#pragma mark - lifecycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CGFloat contentWidth = self.view.bounds.size.width * 5;
//    CGFloat contentHeight = self.galleryScrollView.bounds.size.height;
//    CGFloat frameH = self.galleryScrollView.bounds.size.height;
//    NSLog(@"%f",contentHeight);
//    NSLog(@"%f",frameH);
//    [self.galleryScrollView setAutoresizesSubviews:NO];
//    [self.galleryScrollView setAutoresizingMask:UIViewAutoresizingNone];
//    self.galleryScrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
//    UIImage *img = [UIImage imageNamed:@"catee"];
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
//    [imgView setBackgroundColor:[UIColor blackColor]];
//    imgView.frame = CGRectMake(0, 0, 300, 300);
//    [imgView setContentMode:UIViewContentModeScaleAspectFit];
//    [self.galleryScrollView addSubview:imgView];
//    [self.galleryScrollView setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
//    
    //self.galleryScrollView.galleryContainerView
    
//    self.galleryScrollView.galleryDelegate = self;
//    
//    self.galleryScrollView.contentSize = CGSizeMake(5000, 500);
//    [self.galleryScrollView setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - accessors

//- (VehicleGalleryScrollView *)galleryScrollView {
//        if( !_galleryScrollView) {
//            _galleryScrollView = [[VehicleGalleryScrollView alloc] init];
//            if ([_galleryScrollView isKindOfClass:[VehicleGalleryScrollView class]]) {
//                [self.view addSubview:self.galleryScrollView];
//               // [self.galleryScrollView setFrame:self.view.frame];
//                self.galleryScrollView.galleryDelegate = self;
//
//            } else {
//                return nil;
//            }
//        }
//        return _galleryScrollView;
//
//}
@end
