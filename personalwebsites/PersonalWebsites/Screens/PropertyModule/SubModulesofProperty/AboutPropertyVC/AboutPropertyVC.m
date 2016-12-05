//
//  AboutPropertyVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 14/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "AboutPropertyVC.h"
#import "RichTextBaseController.h"

//#define kLoadHtmlStr    @"<html><body><h1>Rello </h1><h1>Rello </h1><h1>Rell </h1></body></html>"

#define kHtmlFormat  @"<html><body>%@</body></html>"

#define kGap            22
#define kBottomMargin   6
#define kYPadding       8


@interface AboutPropertyVC ()<RichTextBaseControllderDelegate, UITextFieldDelegate>

@end

@implementation AboutPropertyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
    // Do any additional setup after loading the view from its nib.
    [self hideAllValidationMsgField: YES];
    
    [self hideRightNavigationItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) hideAllValidationMsgField:(BOOL) isHide{
    self.reqHeadMsgLbl.hidden = isHide;
    self.reqHdtitleMsgLbl.hidden = isHide;
    self.reqContentMsgLbl.hidden = isHide;
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    //Set background color of uiwebview.
//    self.mWebView.backgroundColor = kInputFieldBGColor;
//    self.mWebView.opaque = NO;
}


//- (void)addTapGestureToWebView
//{
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(webviewTapped)];
//    
//    gesture.delegate = self;
//
//    [self.mWebView addGestureRecognizer:gesture];
//}



- (void)configureUI
{
    [Utility makeRoundedBorderOnView:self.headingView];
    [Utility makeRoundedBorderOnView:self.headingTitleView];
    [Utility makeRoundedBorderOnView:self.contentView];
    
    //Set background color of uiwebview.
    self.mWebView.backgroundColor = kInputFieldBGColor;
    self.mWebView.opaque = NO;

    self.contentScrollView.scrollEnabled = YES;
    
    [Utility addFAUIOnButton:self.editButton andFATitle:kEditFAIcon andColor:kNavColor andFont:kFAIconSize+1];
    
 }



- (IBAction)userPressedEditButton:(UIButton *)sender {
    
    [self openTextEditor];
}


- (void)openTextEditor
{
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    RichTextBaseController *editorVC = [[RichTextBaseController alloc] init];
    
    editorVC.delegate = self;
    
    editorVC.screenTitle = kPropertyScreenTitle;
    
    if(![Utility isEmptyOrNilForString: self.contentStr]){
        [editorVC setHTML:self.contentStr];
    }
    
    [self.navigationController pushViewController:editorVC animated:NO];
}


#pragma mark - UITextfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   if(textField == self.headingTextField)
    {
        [self.headingTitleTextField becomeFirstResponder];
    }
    else
    {
        [self.view endEditing:YES];
    }
    
    return YES;
}


#pragma mark - Rich Text Editor Delegate

- (void)userDidSavedHTMLContent:(NSString *)htmlContent
{
    NSString *html = [NSString stringWithFormat:kHtmlFormat,htmlContent];
    
    NSLog(@"Changed:%@", html);
    
    self.contentStr = htmlContent;
    
    [self.mWebView loadHTMLString:html baseURL:nil];
   
}


- (IBAction)didUserPressedSubmitButton:(PWButton *)sender {
    //Validate All input.
    if([self isAllInputValid]){
        NSLog(@"All good");
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}



- (BOOL) isAllInputValid{
    
    BOOL isValidInput = YES;
    
    if([Utility isEmptyOrNilForString:self.headingTextField.text]){
    isValidInput = NO;
        self.reqHeadMsgLbl.hidden = NO;
    }else{
        self.reqHeadMsgLbl.hidden = YES;
    }
    
    
    if([Utility isEmptyOrNilForString:self.headingTitleTextField.text]){
    isValidInput = NO;
        self.reqHdtitleMsgLbl.hidden = NO;
    }else{
        self.reqHdtitleMsgLbl.hidden = YES;
    }
    
    if([Utility isEmptyOrNilForString:self.contentStr]){
        isValidInput = NO;
        self.reqContentMsgLbl.hidden = NO;
    }else{
        self.reqContentMsgLbl.hidden = YES;
    }
    
    return isValidInput;
}

@end
