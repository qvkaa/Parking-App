//
//  GalleryViewController.m
//  Parking App
//
//  Created by yavoraleksiev on 3/2/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "GalleryViewController.h"

@interface GalleryViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *galleryScrollView;
@property (weak, nonatomic) IBOutlet UIView *containerSize;

@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerSize.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat a = self.view.bounds.size.height;
    CGFloat b = self.view.frame.size.height;
    CGFloat c = self.containerSize.bounds.size.height;
    CGFloat d = self.containerSize.frame.size.height;

    CGSize size = self.containerSize.frame.size;
    //size.width *= 2;
    //self.galleryScrollView.contentSize = size;
    // Do any additional setup after loading the view.
    // 1
    UIImage *image = [UIImage imageNamed: @"catee"];
    UIImageView *imageView= [[UIImageView alloc] initWithImage:image];
    CGFloat h = self.containerSize.bounds.size.height;
    CGFloat w = self.containerSize.bounds.size.width;
    imageView.frame = CGRectMake(0, 0, w, h);
    //[imageView setContentMode:UIViewContent];
   // self.containerSize.contentSize = CGSizeMake(w*2, h);
    [self.containerSize addSubview:imageView];
    //imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:image.size)
    //scrollView.addSubview(imageView)
    
    // 2
    //scrollView.contentSize = image.size
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
