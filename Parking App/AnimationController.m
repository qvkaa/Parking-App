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
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = self.presenting ? toView :[transitionContext viewForKey:UITransitionContextFromViewControllerKey];
    CGRect initialFrame = self.presenting ? self.originFrame : fromView.frame;
    CGRect finalFrame = self.presenting ? fromView.frame : self.originFrame;
    
    CGFloat xScaleFactor = self.presenting ? (initialFrame.size.width / finalFrame.size.width) : (finalFrame.size.width / initialFrame.size.width);
    
    CGFloat yScaleFactor = self.presenting ? (initialFrame.size.height) / (finalFrame.size.height) : (finalFrame.size.height) / (initialFrame.size.height);
}

@end
