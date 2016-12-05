//
//  PWFloatingLabel.m
//  PersonalWebsites
//
//  Created by vectoscalar on 03/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "PWFloatingLabel.h"

@implementation PWFloatingLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {5, 5, 5, 5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
