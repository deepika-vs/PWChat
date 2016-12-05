//
//  FloatingMenuView.m
//  PersonalWebsites
//
//  Created by vectoscalar on 24/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "FloatingMenuView.h"

#define kCornerRadius 24.0f

@implementation FloatingMenuView
@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)userPressedCallButton:(id)sender {
    
    [Utility makeACallWithPhoneNumber:kPhoneNumber];
}

- (IBAction)userPressedChatButton:(id)sender {
}

- (IBAction)userPressedEmailButton:(id)sender {
    
    [delegate userDidPressedEmailButtonOnView:self];
}

- (void)configureView
{
    self.blurView.layer.cornerRadius  = kCornerRadius;
}



@end
