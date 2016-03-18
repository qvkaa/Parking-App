//
//  CustomSegue.m
//  Parking App
//
//  Created by yavoraleksiev on 3/18/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "CustomSegue.h"

@implementation CustomSegue

- (void)perform {
//    UIView *containerView = [transitionContext containerView];
//    UIViewController *toController = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey ];
//    UIView *toView = toController.view;
//    UIView *fromView;
//    UIViewController *fromController;
//    
//    if (self.presenting) {
//        fromView = toView;
//    } else {
//        fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
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
    
    UIViewController *fromController = (UIViewController*)[self sourceViewController];
    UIViewController *toController = (UIViewController*)[self destinationViewController];
    UIView *toView = toController.view;
    UIView *fromView;
    fromView = toView;
    CGRect initialFrame;
    initialFrame = CGRectZero;
    CGRect finalFrame;
    finalFrame = fromView.frame;
    CGFloat xScaleFactor;
    xScaleFactor = (initialFrame.size.width / finalFrame.size.width);
    CGFloat yScaleFactor;
    yScaleFactor =  (initialFrame.size.height) / (finalFrame.size.height);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
    fromView.transform = scaleTransform;
    fromView.center = CGPointMake(CGRectGetMidX(initialFrame),CGRectGetMidY(initialFrame));
    fromView.clipsToBounds = YES;
    //CATransition* transition = [CATransition animation];
    [UIView animateWithDuration:0.3 delay:0.4 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
        fromView.transform  = CGAffineTransformIdentity;
        fromView.center = CGPointMake(CGRectGetMidX(finalFrame),CGRectGetMidY(finalFrame));
    } completion: ^(BOOL finished ){
    
    }];
        
//    transition.duration = .25;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
//    transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
//    
//    
//    
//    [fromController.navigationController.view.layer addAnimation:transition
//                                                                forKey:kCATransition];
    //[sourceViewController.tabBarController addChildViewController:destinationController];
    [fromController.navigationController pushViewController:toController animated:NO];
}
@end
