//
//  SocialLinkVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 29/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "SocialLinkVC.h"

#define kScreenTitle @"Social Links"

@interface SocialLinkVC ()<UITextFieldDelegate>

@end

@implementation SocialLinkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.needToShowBackButton = YES;
    self.navigationItem.title = kScreenTitle;
    [self createNavigationBarLeftItems];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    [self configureView];
    
    if(kScreenWidth > 330)
    {
        self.mScrollView.scrollEnabled = NO;
    }
    
    self.googleTextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.twitterTextField.keyboardType = UIKeyboardTypeTwitter;
    
    //Hide required fileds.
    self.requiredFbLbl.hidden = YES;
    self.requiredTwLbl.hidden = YES;
    self.requiredGmailLbl.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configureView
{
    [Utility makeRoundedBorderOnView:self.facebookView];
    [Utility makeRoundedBorderOnView:self.googlePlusView];
    [Utility makeRoundedBorderOnView:self.twitterView];
}




#pragma mmark - Textfield Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.faceboobTextField)
    {
        [self.twitterTextField becomeFirstResponder];
    }
    else if(textField == self.twitterTextField)
    {
        [self.googleTextField becomeFirstResponder];
    }
    else
    {
        [self.view endEditing:YES];
    }
    
    return YES;
}



- (IBAction)userPressedSubmitButton:(PWButton *)sender {
    BOOL isFieldRequired = NO;
    
    if([Utility isEmptyOrNilForString: self.faceboobTextField.text] || [Utility validateUrl: self.faceboobTextField.text]){
        self.requiredFbLbl.hidden = NO;
        isFieldRequired = YES;
    }else{
        self.requiredFbLbl.hidden = YES;
    }

    
    if([Utility isEmptyOrNilForString: self.twitterTextField.text] || [Utility validateUrl: self.twitterTextField.text]){
        self.requiredTwLbl.hidden = NO;
        isFieldRequired = YES;
    }else{
        self.requiredTwLbl.hidden = YES;
    }
    
    if([Utility isEmptyOrNilForString: self.googleTextField.text] || [Utility validateUrl: self.googleTextField.text]){
        self.requiredGmailLbl.hidden = NO;
        isFieldRequired = YES;
    }else{
        self.requiredGmailLbl.hidden = YES;
    }
    
    if(isFieldRequired == YES){
        return;
    }
    
    //Add action here.
    [self.navigationController popViewControllerAnimated:YES];
}

@end
