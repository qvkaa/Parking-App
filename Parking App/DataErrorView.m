//
//  DataErrorView.m
//  Parking App
//
//  Created by yavoraleksiev on 2/11/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "DataErrorView.h"

@interface DataErrorView ()




@end

@implementation DataErrorView



#pragma mark - Method for delegate
- (IBAction)closeErrorButton:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(closeErrorView:)]) {
        [self.delegate closeErrorView:YES];
         //self.hidden = YES;
    }
}


@end
