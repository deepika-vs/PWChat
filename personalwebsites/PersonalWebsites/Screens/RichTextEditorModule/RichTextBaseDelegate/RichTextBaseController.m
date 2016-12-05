//
//  RichTextBaseController.m
//  PersonalWebsites
//
//  Created by vectoscalar on 05/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "RichTextBaseController.h"

#define kNegativeMargin -8
#define kNavbarHeight 44
#define kRightNavigatioButtonSize 23

#define kMenuIcon           @"MenuIcon"
#define kBackIcon           @"backArrow"
#define kForwardImage       @"forwardArrow"
#define kReloadImage        @"reloadImage"
#define kgoBackArrow        @"goBackArrow"
#define kNotificationIcon   @"notificationIcon"
#define kSaveBtnTitle       @"Save"

@interface RichTextBaseController ()

@end

@implementation RichTextBaseController
@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self managerNavigationStyle];
    self.navigationItem.title = self.screenTitle;
    
    [self createRightNavigationItem];
    
    [self createNavigationBarLeftItems];
    // Do any additional setup after loading the view.
}


- (void)viewWillDisappear:(BOOL)animated
{
   // [self viewWillDisappear:YES];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)managerNavigationStyle
{
    self.navigationController.navigationBar.backgroundColor = kNavColor;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = kNavColor;
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];

}

- (void)hideNavigationBackButton
{
    self.navigationItem.hidesBackButton  = YES;
}


- (void)createNavigationBarLeftItems
{
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, kNavbarHeight)];
    leftView.backgroundColor = [UIColor clearColor];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftButton.frame = CGRectMake(0, 0, 50, kNavbarHeight);
    leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
    
    leftButton.backgroundColor = [UIColor clearColor];
    
    
    [leftView addSubview:leftButton];
    
    [Utility addFAUIOnButton:leftButton andFATitle:kNavBackButtonFA andColor:[UIColor whiteColor] andFont:kFAIconSize + 18];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton= YES;
    
    [leftButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
 
    
    leftButton.backgroundColor = [UIColor clearColor];
    
    [leftView addSubview:leftButton];
    
    //Add To Navigation Left View
    UIBarButtonItem *leftBarButtonView = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    
    
    //Space to minimize the left margin
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil action:nil];
    negativeSpacer.width = kNegativeMargin;
    
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,leftBarButtonView]];
    
}




- (void)createRightNavigationItem
{
    //BackBUtton
    UIButton *notify = [UIButton buttonWithType:UIButtonTypeCustom];
   [notify setTitle:kSaveBtnTitle forState:UIControlStateNormal];
    [notify.titleLabel setFont:[UIFont fontWithName:kFontNameWithBold size:13]];
//    [notify setImage:[UIImage imageWithIcon:kSaveFA backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] andSize:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    
    notify.frame = CGRectMake(0, 0, kRightNavigatioButtonSize+20,kRightNavigatioButtonSize+10);
    [notify addTarget:self action:@selector(saveButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton  = [[UIBarButtonItem alloc] initWithCustomView:notify];
    backButton.image = [backButton.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.navigationItem setRightBarButtonItem:backButton];
}


- (void)saveButtonPressed
{
    NSLog(@"----%@",[self getHTML]);
    [delegate userDidSavedHTMLContent:[self getHTML]];
    [self backButtonPressed];
}

- (void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
