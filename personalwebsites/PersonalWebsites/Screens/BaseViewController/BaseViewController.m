//
//  BaseViewController.m
//  SportInfo
//
//  Created by VectoScalar on 4/21/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "BaseViewController.h"

#define kNegativeMargin             -8
#define kNavbarHeight               44
#define kRightNavigatioButtonSize   20

#define kMenuIcon                   @"MenuIcon"
#define kBackIcon                   @"backArrow"
#define kForwardImage               @"forwardArrow"
#define kReloadImage                @"reloadImage"
#define kgoBackArrow                @"goBackArrow"
#define kNotificationIcon           @"notificationIcon"

#define kNewFloatingSize    kFloatingButtonSize //(1.5*kFloatingButtonSize)



@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    self.navigationController.navigationBar.backgroundColor = kNavColor;
  
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
     view.backgroundColor = kNavColor;
    
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];

    
    
    // Do any additional setup after loading the view.
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)manager:(APIManager *)manager didFailedForMapper:(APIMapper *)mapper{
    
    
}


- (void)manager:(APIManager *)manager didFinishedForMapper:(APIMapper *)mapper{
    
    
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
    leftButton.frame = CGRectMake(0, 0, 100, kNavbarHeight);
    
    
    leftButton.backgroundColor = [UIColor clearColor];
    [leftView addSubview:leftButton];
    
    NSString *kFontLeft;
    CGFloat fontSize;
    
    if(self.needToShowBackButton){
        leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 75);
        kFontLeft = kNavBackButtonFA;
        fontSize = kFAIconSize + 18;
    }
    else{
        [leftButton setImage:[UIImage imageNamed:kMenuIcon] forState:UIControlStateNormal];
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(11, 5, 11, 75);
    }
    
    [Utility addFAUIOnButton:leftButton andFATitle:kFontLeft andColor:[UIColor whiteColor] andFont:fontSize];
    
    //Create Button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, kNavbarHeight);
    
    if(self.needToShowBackButton)
       {
           self.navigationItem.leftBarButtonItem = nil;
           self.navigationItem.hidesBackButton= YES;
           [btn addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
       }
    else
    {
        [btn addTarget:self action:@selector(menuButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
       
  
    btn.backgroundColor = [UIColor clearColor];
    
    [leftView addSubview:btn];

    
    //Add To Navigation Left View
    UIBarButtonItem *leftBarButtonView = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    
    
    //Space to minimize the left margin
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil action:nil];
    negativeSpacer.width = kNegativeMargin;
    
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,leftBarButtonView]];

}



- (void)menuButtonPressed
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}




- (void)createRightNavigationItem:(NSString *) titleFAStr andSize:(CGFloat) size
{
    //Right navButton.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, kRightNavigatioButtonSize,kRightNavigatioButtonSize);
   
    [Utility addFAUIOnButton:button andFATitle:titleFAStr andColor:[UIColor whiteColor] andFont:size];
    
    [button addTarget:self action:@selector(userTappedOnRightBarButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton  = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    [self.navigationItem setRightBarButtonItem:rightButton];
}


- (void)removeRightNavItem{
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)hideRightNavigationItem
{
    self.navigationItem.rightBarButtonItem.customView.hidden = YES;
}


- (void)showRightNavigationItem
{
    self.navigationItem.rightBarButtonItem.customView.hidden = NO;
}


- (void)userTappedOnRightBarButton:(id) sender
{
//Implement here
}

- (void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  - Create Floating Button

- (void)createFloatingButton
{

    UIButton *floatingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGRect btnFrame = kFloatingBtnFrame;
    btnFrame.origin.y = self.view.frame.size.height - (kFloatingButtonSize + 15);
    
    floatingButton.frame = btnFrame;
    
    //floatingButton.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    
    [Utility addFAUIOnButton:floatingButton andFATitle:kPlusFA andColor:[UIColor whiteColor] andFont:kFAIconSize];
    
    
    [floatingButton setBackgroundColor:kNavColor];
    
    [floatingButton addTarget:self action:@selector(floatingButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    floatingButton.layer.cornerRadius = floatingButton.frame.size.height/2;
    
    [Utility addShadowToFloatingButton:floatingButton];
    
    [self.view addSubview:floatingButton];
}


//Override this method in every class where floating button is added
- (void)floatingButtonTapped
{
   //Override this method;
}

@end
