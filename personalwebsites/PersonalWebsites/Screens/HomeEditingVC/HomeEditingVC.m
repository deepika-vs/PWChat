//
//  HomeEditingVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 29/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "HomeEditingVC.h"
#import "RichTextEditorVC.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

#define kHomeTitle              @"Home"
#define kRichTextEditorVCXIB    @"RichTextEditorVC"
#define kContentTitle           @"Content"

#define kTextBoxFactor      10
#define kTexViewAdjustemnt  24

@interface HomeEditingVC ()<UITextFieldDelegate, UIWebViewDelegate>

@end

@implementation HomeEditingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.needToShowBackButton = YES;
    [self createNavigationBarLeftItems];
    
    self.navigationItem.title = kHomeTitle;
    
    self.mWebView.delegate = self;
    
    [Utility addFAUIOnButton:self.editButton andFATitle:kEditFAIcon andColor:kNavColor andFont:kFAIconSize+1];
    
    [self configureView];
    // Do any additional setup after loading the view from its nib.
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Set background color of uiwebview.
    self.mWebView.backgroundColor = kInputFieldBGColor;
    self.mWebView.opaque = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}



- (void)configureView
{
    [Utility makeRoundedBorderOnView:self.headingTextViewWrapperView];
    [Utility makeRoundedBorderOnView:self.contentWrapperView];
    
    //Set scroll view enable to webview.
    self.mWebView.scrollView.scrollEnabled = YES;
    self.mWebView.contentMode = UIViewContentModeScaleAspectFit;
    
    if(self.contentHtmlText != nil){
        //Set font-family & size;
        self.contentHtmlText = [Utility setWebViewHTMLTextFont: self.contentHtmlText];
        
        //Set text to uiwebview.
        [self.mWebView loadHTMLString:self.contentHtmlText baseURL:nil];
    }
}


#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}


#pragma mark - RichTextEditor Base Delegate

- (void)userDidSavedHTMLContent:(NSString *)htmlString
{
    self.contentHtmlText = [Utility setWebViewHTMLTextFont: htmlString];
    
    [self.mWebView loadHTMLString:self.contentHtmlText baseURL:nil];
}



- (IBAction)userPressedEditButton:(UIButton *)sender {
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    RichTextBaseController *editorVC = [[RichTextBaseController alloc] init];
    editorVC.delegate = self;
    editorVC.screenTitle = kContentTitle;
    
    //Show text to editor.
    [editorVC setHTML: self.contentHtmlText];
    [self.navigationController pushViewController:editorVC animated:NO];
}


@end
