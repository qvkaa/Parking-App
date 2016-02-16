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

@synthesize delegate = _delegate;

#pragma mark - Lifecycle
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        self =[[[NSBundle mainBundle] loadNibNamed:@"DataErrorView" owner:nil options:nil] lastObject];
//        if ([self isKindOfClass:[DataErrorView class]]) {
//            return self;
//        } else {
//            return nil;
//        }
//    }
//    return self;
//}
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        self =[[[NSBundle mainBundle] loadNibNamed:@"DataErrorView" owner:nil options:nil] lastObject];
//        if ([self isKindOfClass:[DataErrorView class]]) {
//            return self;
//        } else {
//            return nil;
//        }
//    }
//    return self;
//
//}
//+ (id)errorView
//{
//    DataErrorView *dataErrorView = [[[NSBundle mainBundle] loadNibNamed:@"DataErrorView" owner:nil options:nil] lastObject];
//    
//  
//    if ([dataErrorView isKindOfClass:[DataErrorView class]]) {
//        return dataErrorView;
//    } else {
//        return nil;
//    }
//
//}

- (IBAction)closeErrorButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(closeErrorView:)]) {
        [self.delegate closeErrorView:YES];
         //self.hidden = YES;
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
