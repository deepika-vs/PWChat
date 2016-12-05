//
//  SocialLinkVC.h
//  PersonalWebsites
//
//  Created by vectoscalar on 29/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWButton.h"
#import "PWTextField.h"
#import "BaseViewController.h"


@interface SocialLinkVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *facebookView;
@property (weak, nonatomic) IBOutlet UIView *twitterView;
@property (weak, nonatomic) IBOutlet UIView *googlePlusView;

@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet PWTextField *faceboobTextField;
@property (weak, nonatomic) IBOutlet PWTextField *twitterTextField;
@property (weak, nonatomic) IBOutlet PWTextField *googleTextField;

//Requred fileds.
@property (weak, nonatomic) IBOutlet UILabel *requiredFbLbl;
@property (weak, nonatomic) IBOutlet UILabel *requiredTwLbl;
@property (weak, nonatomic) IBOutlet UILabel *requiredGmailLbl;


- (IBAction)userPressedSubmitButton:(PWButton *)sender;

@end
