//
//  DataErrorView.h
//  Parking App
//
//  Created by yavoraleksiev on 2/11/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DataErrorViewDelegate <NSObject>
// Required means if they want to use the delegate they
// have to implement it.
@required
- (void)closeErrorView:(BOOL)complete;
@end

@interface DataErrorView : UIView
@property (weak, nonatomic) id<DataErrorViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end
