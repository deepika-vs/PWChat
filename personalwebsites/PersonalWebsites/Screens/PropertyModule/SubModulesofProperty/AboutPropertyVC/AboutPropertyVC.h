//
//  AboutPropertyVC.h
//  PersonalWebsites
//
//  Created by vectoscalar on 14/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWButton.h"
#import "PWTextField.h"
#import "BaseViewController.h"

@interface AboutPropertyVC : BaseViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet PWTextField *headingTitleTextField;
@property (weak, nonatomic) IBOutlet PWTextField *headingTextField;


@property (weak, nonatomic) IBOutlet UIView *headingView;
@property (weak, nonatomic) IBOutlet UIView *headingTitleView;

@property (weak, nonatomic) IBOutlet UIWebView *mWebView;

@property (strong, nonatomic) NSString *contentStr;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;


@property (weak, nonatomic) IBOutlet UIButton *editButton;

- (IBAction)userPressedEditButton:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet PWButton *submitButton;

- (IBAction)didUserPressedSubmitButton:(PWButton *)sender;

//Validation fields.
@property (weak, nonatomic) IBOutlet UILabel *reqHeadMsgLbl;
@property (weak, nonatomic) IBOutlet UILabel *reqHdtitleMsgLbl;
@property (weak, nonatomic) IBOutlet UILabel *reqContentMsgLbl;


@end
