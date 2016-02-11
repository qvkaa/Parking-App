//
//  DataValidateView.m
//  Parking App
//
//  Created by yavoraleksiev on 2/9/16.
//  Copyright © 2016 Yavor Aleksiev. All rights reserved.
//

#import "DataValidateView.h"

@implementation DataValidateView

- (void)awakeFromNib {
   DataValidateView* myViewObject= [[[NSBundle mainBundle] loadNibNamed:@"ErrorView" owner:self options:nil] firstObject];
    //self.errorMessageView.frame = self.bounds;
    //[self addSubview:self.errorMessageView];
    
    [super awakeFromNib];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - IBAction

- (IBAction)errorButtonConfirmation:(id)sender {
    
}

@end
