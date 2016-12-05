//
//  PWButton.m
//  PersonalWebsites
//
//  Created by vectoscalar on 29/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "PWButton.h"

#define kButtonBGColor kNavColor

@implementation PWButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 
*/


- (void)drawRect:(CGRect)rect {
    

    self.layer.cornerRadius = 4.0f;
    self.clipsToBounds = YES;

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];

   [self setBackgroundColor:kButtonBGColor];
   [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    

    return self;
}


@end
