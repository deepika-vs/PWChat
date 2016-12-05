//
//  GuestHomeView.m
//  PersonalWebsites
//
//  Created by vectoscalar on 24/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "GuestHomeView.h"
#import "MenuSliderViewController.h"
#import "MFSideMenu.h"

@implementation GuestHomeView
@synthesize delegate;

- (IBAction)userPressedLoginButton:(id)sender {
 
    [delegate userPressedLoginButtonOnGuestView];

}


@end
