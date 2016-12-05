//
//  UserLoginVC.h
//  SportInfo
//
//  Created by vectoscalar on 24/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface UserLoginVC : BaseViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property (weak,  readwrite) IBOutlet UITextField *userNameTextField;
@property (weak,  readwrite) IBOutlet UITextField *passTextField;

@property (weak, nonatomic) IBOutlet UIView *uiviewScroll;
@property (weak, nonatomic) IBOutlet UIView *loginFieldView;
@property (weak, nonatomic) IBOutlet UITextField *domainTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *passwordView;

@property (weak, nonatomic) IBOutlet UIView *domainView;
@property (weak, nonatomic) IBOutlet UIView *domainBlurView;

@property (weak, nonatomic) IBOutlet UILabel *listItemLabel;


@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;

@property (weak, nonatomic) IBOutlet UILabel *requireDomainLbl;
@property (weak, nonatomic) IBOutlet UILabel *requireUnameLbl;
@property (weak, nonatomic) IBOutlet UILabel *requirePassLbl;

-(IBAction)loginButtonPressed:(UIButton*)sender;
@end
