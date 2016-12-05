//
//  HomeEditingVC.h
//  PersonalWebsites
//
//  Created by vectoscalar on 29/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PWButton.h"
#import "PWTextField.h"
#import "RichTextBaseController.h"

@interface HomeEditingVC : BaseViewController<UITextFieldDelegate,UITextViewDelegate,RichTextBaseControllderDelegate>

//Heading view.
@property (weak, nonatomic) IBOutlet UIView *headingTextViewWrapperView;
@property (weak, nonatomic) IBOutlet PWTextField *headingTextField;


//@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;

@property (weak, nonatomic) IBOutlet UIView *contentWrapperView;

@property (weak, nonatomic) IBOutlet UIWebView *mWebView;

@property (strong, nonatomic) NSString *contentHtmlText;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

- (IBAction)userPressedEditButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet PWButton *submitButton;

@end
