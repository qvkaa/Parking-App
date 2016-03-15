//
//  TransitionAnimator.h
//  Parking App
//
//  Created by yavoraleksiev on 3/15/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol UIViewControllerAnimatedTransitioning;
@protocol UIViewControllerContextTransitioning;


@interface TransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@end
