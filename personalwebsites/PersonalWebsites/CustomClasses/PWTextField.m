//
//  PWTextField.m
//  PersonalWebsites
//
//  Created by vectoscalar on 26/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "PWTextField.h"

@implementation PWTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (id)init
//{
//    self = [super init];
//    
//    if(self)
//    {
//        self.layer.cornerRadius = 0;
//        self.layer.borderColor = [UIColor colorWithRed:6.0/255.0f green:217.0/255.0f blue:149.0/255.0f alpha:1.0].CGColor;
//        self.layer.borderWidth = 0.8f;
//    }
//    
//    return  self;
//}

- (void)drawRect:(CGRect)rect
{
 
    self.layer.sublayerTransform = CATransform3DMakeTranslation(6, 0, 0);
    

}



@end
