//
//  NavigationControllerCoordinator.m
//  Parking App
//
//  Created by yavoraleksiev on 3/21/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "NavigationControllerCoordinator.h"
#import "AnimationController.h"

@interface NavigationControllerCoordinator()

@property (strong, nonatomic) AnimationController *transition;

@end

@implementation NavigationControllerCoordinator
+ (id)defaultCoordinator {
    static NavigationControllerCoordinator *sharedCoordinator = nil;
    @synchronized (self) {
        if (sharedCoordinator == nil)
            sharedCoordinator = [[self alloc] init];
    }
    return sharedCoordinator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        self.pushTransition.presenting = YES;
        return self.transition;
    } else if (operation == UINavigationControllerOperationPop) {
        return nil;
//        self.pushTransition.presenting = NO;
//        return self.transition;
    }
    return nil;
}

#pragma mark - acecssors
- (AnimationController *)pushTransition {
    if (!_transition) {
        _transition = [[AnimationController alloc] init];
    }
    return _transition;
}
@end