//
//  DataErrorView.h
//  Parking App
//
//  Created by yavoraleksiev on 2/11/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DataErrorViewDelegate
// Required means if they want to use the delegate they
// have to implement it.
@required
- (void)closeErrorView:(BOOL)complete;
@end

@interface DataErrorView : UIView
#pragma mark - delegate
@property (nonatomic,assign) id delegate;
#pragma mark - UILabel
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

#pragma mark - Lifecycle
//- (instancetype)init;
//- (instancetype)initWithFrame:(CGRect)frame;
//+ (id)errorView;


@end
