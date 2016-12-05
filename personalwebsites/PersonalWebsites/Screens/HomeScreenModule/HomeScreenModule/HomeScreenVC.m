//
//  HomeScreenVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 24/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "HomeScreenVC.h"
#import "GuestHomeView.h"
#import "AdminHomeView.h"
#import "FloatingMenuView.h"
#import "MenuSliderViewController.h"
#import "NotificationViewController.h"
#import "MessageController.h"


#define kGuestViewNib           @"GuestHomeView"
#define kFloatingViewNib        @"FloatingMenuView"

#define kAdminViewNib           @"AdminHomeView"
#define kNotificitionViewNib    @"NotificationViewController"

#define kRecipetent             @"sample@gmail.com"
#define kEmailSubject           @"Insert Subject"
#define kEmailNotConfigured     @"Please configure any e-mail account."

#define kEmailNotSent           @"Unable to send e-mail."
#define kScreenTitle            @"Dashboard"




@interface HomeScreenVC ()<FloatingViewDelegate,UIWebViewDelegate,GuestViewDelegate,AdminHomeViewDelegate>

{
    UIActivityIndicatorView *activityIndicatorView;
    GuestHomeView *guestView ;
    AdminHomeView *adminView;
    
    BOOL isScreenLoaded;
}

@end

@implementation HomeScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
   // self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = kScreenTitle;
    [self hideNavigationBackButton];
    [self createNavigationBarLeftItems];
  
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   if([[DataManager sharedDataManager] isUserLoggedIn])
   {
       self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
       
       [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
       [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"transparentNav"] forBarMetrics:UIBarMetricsDefault];
       self.navigationController.navigationBar.shadowImage = [UIImage new];
       self.navigationController.navigationBar.translucent = YES;
   }
    
}


- (void)viewDidLayoutSubviews
{
     if(!isScreenLoaded)
     {
         isScreenLoaded = YES;
          [self performSelector:@selector(configureHomeSetup) withObject:nil afterDelay:0.00];
     }
}


- (void)configureHomeSetup
{
//   if([[DataManager sharedDataManager] isUserLoggedIn])
//   {
       [self setupViewForAdmin];
//   }
//   else
//   {
//       [self configureViewForGuest];
//   }
    
}



- (void)setupCircleInHomeScreen
{
    [adminView configureUI];
}


//Guest Setup
- (void)configureViewForGuest
{
  //  [self createRightNavigationItemsForGuestHomeScreen];
    [self configureGuestView];
  //  [self addActivityIndicatorView];
  
}


- (void)addActivityIndicatorView
{
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.tintColor = [UIColor blackColor];
    activityIndicatorView.color = [UIColor blackColor];
    activityIndicatorView.hidesWhenStopped  = YES;
    [self.view addSubview:activityIndicatorView];
    activityIndicatorView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2.4);
}

#pragma mark  - Prepare View For Guest

- (void)configureGuestView
{
   guestView = [[[NSBundle mainBundle] loadNibNamed:kGuestViewNib owner:self options:nil] firstObject];
   // [guestView startLoadingURL:kPersonalWebsiteURL];
    guestView.delegate = self;
    guestView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    [self.view addSubview:guestView];

}


#pragma mark - Prepare View For Admin
//Admin Setup
- (void)setupViewForAdmin
{
    //Adding notification on right navigation item.
    [self createRightNavigationItem:KNotificationFA andSize:kFAIconSize + 4];
    
    adminView = [[[NSBundle mainBundle] loadNibNamed:kAdminViewNib owner:self options:nil] firstObject];
    adminView.frame = CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height);
    //   [adminView configureUI];
    adminView.delegate = self;
    [self.view addSubview:adminView];
    
    [self performSelector:@selector(setupCircleInHomeScreen) withObject:nil afterDelay:0.00];
}

//User tap on notification.
- (void)userTappedOnRightBarButton:(id) sender{
    NotificationViewController *notificationVC = [[NotificationViewController alloc] initWithNibName:kNotificitionViewNib bundle:nil];
    [self.navigationController pushViewController:notificationVC animated:YES];
}

#pragma mark - Local Methods

- (void)sendMail
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] init];
        composeViewController.mailComposeDelegate = (id)self;
        [composeViewController setToRecipients:@[kRecipetent]];
        [composeViewController setSubject:kEmailSubject];
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
    else
    {
        [Utility showAlerWithMessage:kEmailNotConfigured onViewController:self];
    }
}

-(void)showChat{
    
    
   // - (IBAction)signUpButtonPressed:(id)sender {
        
        MessageController *controller = (MessageController*)[[UIStoryboard storyboardWithName:@"Main"
                                                                                       bundle:NULL] instantiateViewControllerWithIdentifier:@"Message"];
        [self.navigationController pushViewController:controller animated:YES];
//    }
//    
//    - (IBAction)didTapSignIn:(id)sender {
//    
//        UIViewController *controller = [[UIStoryboard storyboardWithName:@"Main"
//                                                                  bundle:NULL] instantiateViewControllerWithIdentifier:@"Chat"];
//        
//        [self.navigationController pushViewController:controller animated:NO];
        
   // }
    
}

#pragma mark - Mail Composer Delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
//    switch (result)
//    {
//        case MFMailComposeResultCancelled:
//        {
//            [Utility showAlerWithMessage:@"E-mail sending cancelled." onViewController:self];
//            break;
//        }
//        case MFMailComposeResultFailed:
//        {
//            [Utility showAlerWithMessage:@"E-mail sending failed." onViewController:self];
//        }
//        case MFMailComposeResultSaved:
//        {
//            NSLog(@"email saved.");
//            break;
//        }
//        case MFMailComposeResultSent:
//        {
//           [Utility showAlerWithMessage:@"E-mail sent." onViewController:self];
//            break;
//        }
//    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Floating View Delegate

- (void)userDidPressedEmailButtonOnView:(FloatingMenuView *)view
{
    [self sendMail];
}

#pragma mark -  Guest View Delegate

- (void)userPressedLoginButtonOnGuestView
{
    UIViewController *controller = self.menuContainerViewController.leftMenuViewController;
    
    if([controller isKindOfClass:[MenuSliderViewController class]])
    {
        MenuSliderViewController *menuSlider = (MenuSliderViewController*)controller;
        
        [menuSlider presetLoginScreen];
    }
}


#pragma mark - Admin Home Delegate

- (void)userDidSelectPagesInDashboardView:(SelectedPageAction)pageType
{
    UIViewController *controller = self.menuContainerViewController.leftMenuViewController;
    
    MenuSliderViewController *menuSlider;
    
    if([controller isKindOfClass:[MenuSliderViewController class]])
    {
       menuSlider = (MenuSliderViewController*)controller;
    }

    switch (pageType) {
        case HomePage:
            [menuSlider presentHomeEditingScreen];
            break;
        case ContactPage:
            [menuSlider presentContactDetailsScreen];
            break;
        case SocialLinkPage:
            [menuSlider presentSocialLinksScreen];
            break;
        case IcalPage:
            [menuSlider presentICalLinkScreen];
            break;
        case PropertyPage:
            [menuSlider presentProperyPagerScreen];
            break;
        case ReviewPage:
            [menuSlider presentReviewsScreen];
            break;
        default:
            NSLog(@"User selected worng page.");
            break;
    }

}


- (void)userDidPressedFloatingButtonWithIndex:(int)index
{
    if(index == 0)//Chat
    {
        [self showChat];
    }
    else if(index == 1)//Mail
    {
        [self sendMail];
    }
    else//Call
    {
        [Utility makeACallWithPhoneNumber:kPhoneNumber];
    }
}

@end
