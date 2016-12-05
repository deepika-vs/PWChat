//
//  GuestHomeView.h
//  PersonalWebsites
//
//  Created by vectoscalar on 24/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  GuestHomeView;

@protocol GuestViewDelegate <NSObject>

- (void)userPressedLoginButtonOnGuestView;

@end

@interface GuestHomeView : UIView

@property (assign,nonatomic) id <GuestViewDelegate> delegate;

@end
