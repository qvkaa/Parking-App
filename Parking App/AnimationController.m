//
//  AnimationController.m
//  Parking App
//
//  Created by yavoraleksiev on 3/16/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "AnimationController.h"
#import "VehicleGalleryViewController.h"
#import "VehicleListViewController.h"
@interface AnimationController()
@property (nonatomic) CGFloat duration;//    = 1.0

@property (nonatomic) CGRect originFrame;// = CGRect.zero
@end

@implementation AnimationController

#pragma mark - lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _duration = 1.0;
        _presenting = YES;
        _originFrame = CGRectZero;
    }
    return self;
}
// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    VehicleGalleryViewController *toController = (VehicleGalleryViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey ];
    toController.galleryScrollView.backgroundColor = [UIColor whiteColor];
    UIView *toView = toController.view;
    UIView *fromView;
    VehicleListViewController *fromController;
    
    
   if (self.presenting) {
        self.originFrame = toController.originFrame;
    }
    fromController = (VehicleListViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (self.presenting) {
        fromView = toView;
    } else {
        fromView = fromController.view;
    }
    
    CGRect initialFrame;
    if (self.presenting) {
        initialFrame = self.originFrame;
    } else {
        initialFrame = fromView.frame;
    }
    
    CGRect finalFrame;
    if (self.presenting) {
        finalFrame = fromView.frame;
        CGFloat xScaleFactor = (finalFrame.size.width / initialFrame.size.width);
        CGFloat prevHeight = initialFrame.size.height;
        initialFrame.size.width = finalFrame.size.width / xScaleFactor;
        initialFrame.size.height = finalFrame.size.height / xScaleFactor;
        CGFloat currentHeight = initialFrame.size.height;
        CGFloat newY = (currentHeight - prevHeight) / 2;
        initialFrame.origin.y -=    newY;
        fromView.backgroundColor = [UIColor clearColor];
        toController.galleryScrollView.backgroundColor = [UIColor whiteColor];
    } else {
        finalFrame = self.originFrame;
    }
    
    
    CGFloat xScaleFactor;
    if (self.presenting) {
        xScaleFactor = (initialFrame.size.width / finalFrame.size.width);
    } else {
        xScaleFactor = (finalFrame.size.width / initialFrame.size.width);
    }
    CGFloat yScaleFactor;
    if (self.presenting) {
        yScaleFactor =  (initialFrame.size.height) / (finalFrame.size.height);
    } else {
        yScaleFactor = (finalFrame.size.height) / (initialFrame.size.height);
    }
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);

    if (self.presenting) {
        fromView.transform = scaleTransform;
        fromView.center = CGPointMake(CGRectGetMidX(initialFrame),CGRectGetMidY(initialFrame));
        fromView.clipsToBounds = YES;
          //  [fromController.navigationController pushViewController:toController animated:NO];
    }
    
    [containerView addSubview:toView];
    [containerView bringSubviewToFront:fromView];
    
    [UIView animateWithDuration:self.duration delay:0.4 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
        fromView.transform  = self.presenting ? CGAffineTransformIdentity : scaleTransform;
        fromView.center = CGPointMake(CGRectGetMidX(finalFrame),CGRectGetMidY(finalFrame));
    } completion: ^(BOOL finished ){
        [transitionContext completeTransition:finished];
    }];
       
    

    
    // --------
    
//    self.originFrame = toController.originFrame;
//    fromView = toView;
//    fromController = (VehicleListViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    CGRect initialFrame = toController.originFrame;
//    CGRect finalFrame = toController.galleryScrollView.frame;
//    
//    CGFloat xScaleFactor = (finalFrame.size.width / initialFrame.size.width);
//    CGFloat yScaleFactor = (finalFrame.size.height / initialFrame.size.height);
//    xScaleFactor = MIN(xScaleFactor, yScaleFactor);
//    yScaleFactor = MIN(xScaleFactor, yScaleFactor);
//    
//    
//    finalFrame.size.height = initialFrame.size.height * yScaleFactor;
//    finalFrame.size.width = initialFrame.size.width * xScaleFactor;
//    //finalFrame.origin.center = CGPointMake(CGRectGetMidX(initialFrame),CGRectGetMidY(initialFrame));
//    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
//    UIImageView *imageToBeTransformed = fromController.imageToBeAnimated;
//    //imageToBeTransformed.transform = scaleTransform;
//    //imageToBeTransformed.center = CGPointMake(CGRectGetMidX(initialFrame),CGRectGetMidY(initialFrame));
//    //fromView.clipsToBounds = YES;
//    [containerView addSubview:fromView];
//    [containerView bringSubviewToFront:imageToBeTransformed];
//    
//        [UIView animateWithDuration:self.duration delay:0.4 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
//            imageToBeTransformed.transform  =  scaleTransform ;
//            imageToBeTransformed.center = CGPointMake(CGRectGetMidX(finalFrame),CGRectGetMidY(finalFrame));
//        } completion: ^(BOOL finished ){
//            [transitionContext completeTransition:finished];
//        }];

    // ---------
    
    
    
//    if (self.presenting) {
//        self.originFrame = toController.originFrame;
//    }
//    fromController = (VehicleListViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//
//    if (self.presenting) {
//        fromView = toView;
//    } else {
//        fromView = fromController.view;
//    }
//    
//    CGRect initialFrame;
//    if (self.presenting) {
//        initialFrame = self.originFrame;
//    } else {
//        initialFrame = fromView.frame;
//    }
//    
//    CGRect finalFrame;
//    if (self.presenting) {
//        finalFrame = fromView.frame;
//    } else {
//        finalFrame = self.originFrame;
//    }
//    
//    
//    CGFloat xScaleFactor;
//    if (self.presenting) {
//        xScaleFactor = (initialFrame.size.width / finalFrame.size.width);
//    } else {
//        xScaleFactor = (finalFrame.size.width / initialFrame.size.width);
//    }
//    
//    CGFloat yScaleFactor;
//    if (self.presenting) {
//        yScaleFactor =  (initialFrame.size.height) / (finalFrame.size.height);
//    } else {
//        yScaleFactor = (finalFrame.size.height) / (initialFrame.size.height);
//    }
//    
//    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
//    
//    if (self.presenting) {
//        fromView.transform = scaleTransform;
//        fromView.center = CGPointMake(CGRectGetMidX(initialFrame),CGRectGetMidY(initialFrame));
//        fromView.clipsToBounds = YES;
//      //  [fromController.navigationController pushViewController:toController animated:NO];
//    }
//    
//    [containerView addSubview:toView];
//    [containerView bringSubviewToFront:fromView];
//    
//    [UIView animateWithDuration:self.duration delay:0.4 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
//        fromView.transform  = self.presenting ? CGAffineTransformIdentity : scaleTransform;
//        fromView.center = CGPointMake(CGRectGetMidX(finalFrame),CGRectGetMidY(finalFrame));
//    } completion: ^(BOOL finished ){
//        [transitionContext completeTransition:finished];
//    }];
//   
//
}
#pragma mark - private

//- (void) presentAddEntryViewController:
//(AddEntryViewController *)addEntryController
//              overParentViewController:(UIViewController *)parentController
//                    usingContainerView:(UIView *)containerView
//                     transitionContext:
//(id<UIViewControllerContextTransitioning>)transitionContext
//{
//    
//    [containerView addSubview:parentController.view];
//    [containerView addSubview:addEntryController.view];
//    
//    UIView *addEntryView = addEntryController.view;
//    UIView *parentView = parentController.view;
//    CGPoint center = parentView.center;
//    
//    UIInterfaceOrientation orientation =
//    parentController.interfaceOrientation;
//    if (UIInterfaceOrientationIsPortrait(orientation))    {
//        addEntryView.frame = CGRectMake(0.0, 0.0, 280.0, 170.0);
//    }
//    else
//    {
//        addEntryView.frame = CGRectMake(0.0, 0.0, 170.0, 280.0);
//    }
//    
//    addEntryView.center = center;
//    addEntryView.alpha = 0.0;
//    
//    [UIView
//     animateWithDuration:AnimationDuration
//     animations:^{
//         addEntryView.alpha = 1.0;
//     }
//     completion:^(BOOL finished) {
//         [transitionContext completeTransition:YES];
//     }];    
//}

@end
