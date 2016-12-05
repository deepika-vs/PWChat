//
//  ViewController.m
//  SportInfo
//
//  Created by VectoScalar on 4/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "RootViewController.h"
#import "JSONHTTPClient.h"
#import "MenuSliderMapper.h"
#import "MenuSliderViewController.h"
#import "MFSideMenu.h"
#import "AppDelegate.h"


@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    DebugLog(@"viewDidLoad");

    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    _splashScreenView = [[SplashScreenView alloc] initWithFrame:CGRectMake(0,
                                                                           0,
                                                                           screenSize.width,
                                                                           screenSize.height)];
    
    
    [self.view addSubview:_splashScreenView];
    
    [_splashScreenView startAnimation];
    
    // [self downloadMenuSliderData];
    
    [self performSelector:@selector(removeSplashAndPresnentHome) withObject:nil afterDelay:1.0];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
   
    
}


- (void)removeSplashAndPresnentHome{
    
    [_splashScreenView stopAnimation];
    [_splashScreenView removeFromSuperview];
    _splashScreenView = nil;
    
     [self handleNavigationOfViewController];
    
}


- (void)handleNavigationOfViewController
{
     if([[DataManager sharedDataManager] isUserLoggedIn])
     {
         [self presentHomeScreen];

     }
     else
     {
         [self presentLoginScreen];
     }
}


//Present Home Screen
- (void)presentHomeScreen
{
  //Enable Pan Gesture to Bring SLider Menu Controller
    
//    self.menuContainerViewController.panMode = MFSideMenuPanModeCenterViewController | MFSideMenuPanModeSideMenu;
    
    if(self.menuContainerViewController.leftMenuViewController && [self.menuContainerViewController.leftMenuViewController isKindOfClass:[MenuSliderViewController class]])
    {
        MenuSliderViewController *controller = (MenuSliderViewController*)self.menuContainerViewController.leftMenuViewController;
        
        [controller presentHomeScreenAnimated:NO];
    }

}


//Login Screen
- (void)presentLoginScreen
{
    
    if(self.menuContainerViewController.leftMenuViewController && [self.menuContainerViewController.leftMenuViewController isKindOfClass:[MenuSliderViewController class]])
    {
        MenuSliderViewController *controller = (MenuSliderViewController*)self.menuContainerViewController.leftMenuViewController;
        
        [controller presetLoginScreen];
    }
    
}


- (void)downloadMenuSliderData{
}




@end
