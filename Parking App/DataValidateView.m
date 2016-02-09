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
    [[NSBundle mainBundle] loadNibNamed:@"HandyView" owner:self options:nil];
    self.temp.frame = self.bounds;
    [self addSubview:self.temp];
    
    [super awakeFromNib];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
