//
//  AnimationController.m
//  Parking App
//
//  Created by yavoraleksiev on 3/16/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "AnimationController.h"

@interface AnimationController()
@property (nonatomic) CGFloat duration;//    = 1.0
@property (nonatomic) BOOL presenting;  // true
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
    //UIView *toView = (UIView *)[transitionContext viewForKey:UITransitionContextToViewControllerKey];
    UIViewController *toController = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey ];
    UIView *toView = toController.view;
    UIView *fromView;
    UIViewController *fromController;
    if (self.presenting) {
        fromView = toView;
    } else {
        fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        fromView = fromController.view;
    //    fromView = (UIView *)[transitionContext viewForKey:UITransitionContextFromViewControllerKey];
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
    }
    
    [containerView addSubview:toView];
    [containerView bringSubviewToFront:fromView];
    [UIView animateWithDuration:self.duration delay:0.4 usingSpringWithDamping:0.4 initialSpringVelocity:0.0 options:0 animations:^{
        fromView.transform  = self.presenting ? CGAffineTransformIdentity : scaleTransform;
        fromView.center = CGPointMake(CGRectGetMidX(finalFrame),CGRectGetMidY(finalFrame));
    } completion: ^(BOOL finished ){
        [transitionContext completeTransition:finished];
    }];
    

}

@end
