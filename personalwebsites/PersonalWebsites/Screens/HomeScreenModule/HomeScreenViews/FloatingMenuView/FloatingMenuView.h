//
//  FloatingMenuView.h
//  PersonalWebsites
//
//  Created by vectoscalar on 24/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FloatingMenuView;

@protocol FloatingViewDelegate <NSObject>

- (void)userDidPressedEmailButtonOnView:(FloatingMenuView*)view;


@end

@interface FloatingMenuView : UIView

@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;

@property (weak, nonatomic) IBOutlet UIView *blurView;

@property (assign,nonatomic) id <FloatingViewDelegate> delegate;

- (IBAction)userPressedCallButton:(id)sender;

- (IBAction)userPressedChatButton:(id)sender;

- (IBAction)userPressedEmailButton:(id)sender;

- (void)configureView;


@end
