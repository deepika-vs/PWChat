//
//  UserLoginVC.m
//  SportInfo
//
//  Created by vectoscalar on 24/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "UserLoginVC.h"
#import "MFSideMenu.h"
#import "MenuSliderViewController.h"
#import <IQKeyboardManager.h>
#import "DropDownMenuView.h"


#define kUserName @"vs"
#define kPassword @"vs"

#define kCornerRadius 8.0f

#define kScreenTitle                @"Login"
#define kPlaceholderTextPassword    @"Password"
#define kPlaceholderTextUsername    @"Username"
#define kPlaceholderTextDomain      @"Domain"

@interface UserLoginVC ()<UITextFieldDelegate,DropDownMenuDelegate>
{
    CGFloat adjustScrollViewWithValue;}

@end

@implementation UserLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    adjustScrollViewWithValue = 0.0;
    
    _passTextField.delegate = self;
    self.navigationItem.title = kScreenTitle;
    self.needToShowBackButton = YES;
    [self createNavigationBarLeftItems];
    [self addTapGestureToView];
    
    [self makeRoundedBorderOnView:self.passwordView];
    [self makeRoundedBorderOnView:self.loginFieldView];
    [self makeRoundedBorderOnView:self.domainBlurView];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //Change Placeholder Text Color
    [Utility changePlaceholderTextColor:self.userNameTextField withColor:[UIColor colorWithRed:167.0f/255.0f green:167.0f/255.0f blue:167.0f/255.0f alpha:1.0] containsPlaceholderText:kPlaceholderTextUsername];
    [Utility changePlaceholderTextColor:self.passTextField withColor:[UIColor colorWithRed:167.0f/255.0f green:167.0f/255.0f blue:167.0f/255.0f alpha:1.0] containsPlaceholderText:kPlaceholderTextPassword];
     [Utility changePlaceholderTextColor:self.domainTextField withColor:[UIColor colorWithRed:167.0f/255.0f green:167.0f/255.0f blue:167.0f/255.0f alpha:1.0] containsPlaceholderText:kPlaceholderTextDomain];
    
    self.iconLabel.font = kFontAwesomeFont(16);
    self.iconLabel.text = kFontAwesomeText(kDownArrowFA);
    
    [self addGestureToDomain];
    
    self.navigationController.navigationBar.hidden = YES;
    
    //Hide required fileds.
    self.requireDomainLbl.hidden = YES;
    self.requireUnameLbl.hidden = YES;
    self.requirePassLbl.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
   
}

- (void)addGestureToDomain
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(domainViewTapped)];
    [self.domainView addGestureRecognizer:gesture];
}

- (void)domainViewTapped
{
    NSArray *list = [NSArray arrayWithObjects:@"yahoo.co.in",@"google.co.in",@"personalWebsites.org", nil];
    
    [self.view endEditing:YES];
    CGRect innerFrame =
    [self.view convertRect:self.domainBlurView.bounds fromView:self.domainBlurView];
    
    
    DropDownMenuView *menu = [[DropDownMenuView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andListViewFrame:innerFrame andMenuList:list];
    menu.delegate = self;
    [self.view addSubview:menu];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
   self.logoImgView.layer.cornerRadius = self.logoImgView.frame.size.height/2;
    NSLog(@"----Image View Frame-_%@",NSStringFromCGRect(self.logoImgView.frame));
}

- (void)addTapGestureToView
{
    //Dismiss keyboard on outside click.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:false];
}


-(void) showAlertMessage:(NSString*) alertMessage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert Message:-" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


//Handle login button with validation user input field.
-(IBAction)loginButtonPressed:(UIButton*)sender{
    //NSString *password = kPassword;
    //NSString *username = kUserName;
    adjustScrollViewWithValue = 0.0;
//    if([_userNameTextField.text length] < 5 ){
//        [self showAlertMessage:@"Username must be greater than or equal to 6 chars"];
//    }else if([_passTextField.text length]< 5){
//        [self showAlertMessage:@"Password must be greater than or equal to 6 chars"];
//    }
//    else if( [_userNameTextField.text isEqualToString:username] && [_passTextField.text isEqualToString:password]){
//        [self showAlertMessage:@"Successfully loggedin"];
//    }else{
//        [self showAlertMessage:@"Username & password not match..."];
//    }
//
    BOOL isFiledRequired = NO;
    
    if(!(self.requireDomainLbl.hidden = (![self requiredValidateOnTextField:self.domainTextField]))){
        isFiledRequired = YES;
    }
    
    if(!(self.requireUnameLbl.hidden = (![self requiredValidateOnTextField:self.userNameTextField]))){
        isFiledRequired = YES;
    }
    
    if(!(self.requirePassLbl.hidden = (![self requiredValidateOnTextField:self.passTextField]))){
        isFiledRequired = YES;
    }
    
    
    if(isFiledRequired == YES){
        return;
    }
    
    //Add action here.
    //[self.navigationController popViewControllerAnimated:YES];
    
    [self navigateToHomeScreen];
}

- (BOOL) requiredValidateOnTextField:(UITextField *) textField{
    if([textField.text length] == 0){
        return YES;
    }
    
    return NO;
}


- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}


- (void)navigateToHomeScreen
{
    [[DataManager sharedDataManager] loginUser];
    
    
    MenuSliderViewController *menuSliderViewController = (MenuSliderViewController *)self.menuContainerViewController.leftMenuViewController;
    [menuSliderViewController updateNavigationItems];
    [menuSliderViewController presentHomeScreenAnimated:YES];

}

- (void)makeRoundedBorderOnView:(UIView*)view
{
    view.layer.cornerRadius = 4.0f;

}


#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    if(textField == self.domainTextField)
    {
        [self.userNameTextField becomeFirstResponder];
    }
    else if(textField == self.userNameTextField)
    {
        [self.passTextField becomeFirstResponder];
    }
    else
    {
        [self.view endEditing:YES];
    }
    
    return YES;
}

#pragma mark - Drop Down Menu Delegaste

- (void)didUserSelectedMenuOption:(NSString *)selectedOption
{
    self.listItemLabel.text = selectedOption;
}


@end
