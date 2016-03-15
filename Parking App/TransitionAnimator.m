//
//  TransitionAnimator.m
//  Parking App
//
//  Created by yavoraleksiev on 3/15/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "TransitionAnimator.h"

@implementation TransitionAnimator
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
}
@end
