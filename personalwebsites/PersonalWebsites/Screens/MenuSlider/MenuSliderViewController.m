//
//  MenuSliderViewController.m
//  SportInfo
//
//  Created by VectoScalar on 4/21/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "MenuSliderViewController.h"
#import "MenuSliderCell.h"
#import "HomeScreenVC.h"
#import "MFSideMenu.h"
#import "UserLoginVC.h"
#import "ContactDetailsVC.h"
#import "MenuSliderHeader.h"
#import "SocialLinkVC.h"
#import "HomeEditingVC.h"
#import "NavigationWrapper.h"
#import "NavigationSubRows.h"
#import "IcalLinkVC.h"
#import "PropertyPagerController.h"
#import "ReviewsVC.h"


#define kUserLoginVC @"UserLoginVC"
#define kHomeScreenVC @"HomeScreenVC"
#define kContactScreenVC @"ContactDetailsVC"
#define kSocialLinkScreenVC @"SocialLinkVC"
#define kHomeEditingScreenVC @"HomeEditingVC"
#define kSectionView @"MenuSectionView"
#define kIcalScreenVC @"IcalLinkVC"
#define kPropertyScreenVC @"PropertyPagerController"
#define kReviewsScreenVC @"ReviewsVC"

#define kMenuSliderSectionHeaderNIB @"MenuSliderHeader"

#define kMenuSliderCell @"MenuSliderCell"

#define kSectionHeight 50


@implementation MenuSliderViewController{
    NSMutableArray *sectionArray;
    
    UIView *statusView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
     sectionArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(menuStateEventOccurred:)
                                                 name:MFSideMenuStateNotificationEvent
                                               object:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   
    [self configureMenuItems];
    //Configure Table View
    [self configureTableView];
}


- (void)menuStateEventOccurred:(NSNotification *)notification {
    MFSideMenuStateEvent event = [[[notification userInfo] objectForKey:@"eventType"] intValue];
    
    if(event == MFSideMenuStateEventMenuWillOpen)
    {
        statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        [UIView animateWithDuration:0.2 animations:^{
            statusView.backgroundColor = [UIColor blackColor];
            statusView.alpha = 0.7;
        }];
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:statusView];

    }
    else if(event == MFSideMenuStateEventMenuWillClose)
    {
        [UIView animateWithDuration:0.2 animations:^{
           [statusView removeFromSuperview];
        }];
    }
    
}



- (void)configureMenuItems
{
  sectionArray = [NSMutableArray arrayWithArray:[Utility getNavigationMenuForAdmin]];
}

- (void)configureTableView
{
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.menuContainerViewController.leftMenuWidth, kScreenHeight) style:UITableViewStylePlain];
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   // mTableView.allowsSelection = NO;
    mTableView.bounces = NO;
    
    //Set Table Header
    MenuSliderHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:kMenuSliderSectionHeaderNIB owner:self options:nil] firstObject];
    headerView.backgroundColor = kNavColor;
    mTableView.tableHeaderView = headerView;
    
    
    UINib *nib = [UINib nibWithNibName:kMenuSliderCell bundle:nil];
    [mTableView registerNib:nib forCellReuseIdentifier:kMenuSliderCell];

    [self.view addSubview:mTableView];
}


#pragma mark - Handle Navigation

- (void)presentHomeScreenAnimated:(BOOL)animated
{
    HomeScreenVC *homeScreen = [[HomeScreenVC alloc] initWithNibName:kHomeScreenVC bundle:nil];
    [self.menuContainerViewController.centerViewController pushViewController:homeScreen animated:animated];
}



//Present Login Screen
- (void)presetLoginScreen
{
    DebugLog(@"Present Login Screen");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    
    UserLoginVC *loginVC = [storyboard instantiateViewControllerWithIdentifier:kUserLoginVC];
    
    [self.menuContainerViewController.centerViewController pushViewController:loginVC animated:YES];
}

//Navigatwto Home after Login
- (void)presentHomeScreenAfteeLogin
{
  [self.menuContainerViewController.centerViewController popToRootViewControllerAnimated:NO];
    
    [self presentHomeScreenAnimated:YES];
}



//Present Contact Details SCreen
- (void)presentContactDetailsScreen
{
    DebugLog(@"presentContactDetailsScreen");
    
    ContactDetailsVC *contactScreen = [[ContactDetailsVC alloc] initWithNibName:kContactScreenVC bundle:nil];
    
    [self.menuContainerViewController.centerViewController pushViewController:contactScreen animated:YES];
}


//Present Social Links SCreen
- (void)presentSocialLinksScreen
{
    DebugLog(@"presentSocialLinksScreen");
    
    SocialLinkVC *socialScreen = [[SocialLinkVC alloc] initWithNibName:kSocialLinkScreenVC bundle:nil];
    
    [self.menuContainerViewController.centerViewController pushViewController:socialScreen animated:YES];
}

//Present Home Editing Screen
- (void)presentHomeEditingScreen
{
    HomeEditingVC *homeEditingVC = [[HomeEditingVC alloc] initWithNibName:kHomeEditingScreenVC bundle:nil];
    
    [self.menuContainerViewController.centerViewController pushViewController:homeEditingVC animated:YES];
}

//Present ICAL Link Screen
- (void)presentICalLinkScreen
{
    IcalLinkVC *icalLinkVC = [[IcalLinkVC alloc] initWithNibName:kIcalScreenVC bundle:nil];
    
    [self.menuContainerViewController.centerViewController pushViewController:icalLinkVC animated:YES];
}


//Present ICAL Link Screen
- (void)presentProperyPagerScreen
{
    PropertyPagerController *propertyVC = [[PropertyPagerController alloc] initWithNibName:kPropertyScreenVC bundle:nil];
    
    [self.menuContainerViewController.centerViewController pushViewController:propertyVC animated:YES];
}


//Present Reviews Screen
- (void)presentReviewsScreen
{
    ReviewsVC *reviewVC = [[ReviewsVC alloc] initWithNibName:kReviewsScreenVC bundle:nil];
    
    [self.menuContainerViewController.centerViewController pushViewController:reviewVC animated:YES];
}


#pragma mark - UITable View Delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NavigationWrapper *wrapper = [sectionArray objectAtIndex:section];
    
    if(wrapper.isOpen){
        return [wrapper.rows count];
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    NavigationWrapper *wrapper = [sectionArray objectAtIndex:section];
    
    MenuSectionView *sectionView = [[[NSBundle mainBundle] loadNibNamed:kSectionView owner:nil options:nil] firstObject];
    [sectionView updateSectionMenuWithTitle:wrapper.title andImageName:wrapper.iconName];
    sectionView.delegate = self;
    
    if([wrapper.rows count]>0 && !wrapper.isOpen)
        [sectionView updateAccessorView];
    
    else if([wrapper.rows count]>0 && wrapper.isOpen)
         [sectionView updateAccessorViewWithDownArrow];
        
  //  sectionView.backgroundColor = [UIColor redColor];
    sectionView.frame = CGRectMake(0, 0, self.menuContainerViewController.leftMenuWidth, kSectionHeight);
    return sectionView;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kSectionHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kSectionHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuSliderCell *cell =  [tableView dequeueReusableCellWithIdentifier:kMenuSliderCell];
    
    NavigationWrapper *menu = [sectionArray objectAtIndex:indexPath.section];
    
    NavigationSubRows *submenu = [menu.rows objectAtIndex:indexPath.row];
    
    [cell updateMenuWithTitle:submenu.title withImageName:submenu.iconName];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if(indexPath.section == 1)
    {
        [self handleMenuSelectionForEditPages:(int)indexPath.row];
        [self closeNavigationDrawer];
    }
    else
    {
        [self handleMenuSelectionForContact:(int)indexPath.row];
    }
   
}

#pragma mark - Local Methods

- (void)resetNavigationMenu
{
    for(NavigationWrapper *wr in sectionArray)
    {
            wr.isOpen = NO;
    }
    [mTableView reloadData];
}


//Handle Navigation For Edit Pages
- (void)handleMenuSelectionForEditPages:(int)index
{
    
    if(index == 0)//Home Editing Screen
    {
        [self presentHomeEditingScreen];
    }
    else if(index == 1)//Property Screen
    {
        [self presentProperyPagerScreen];
    }
    else if(index ==2)//Ical Screen
    {
        [self presentICalLinkScreen];
    }
    else if(index == 3)//Contact
    {
        [self presentContactDetailsScreen];
    }
    else if(index == 4)//Review
    {
        [self presentReviewsScreen];
    }
    else if(index == 5) //Social Links
    {
        [self presentSocialLinksScreen];
    }
    
}

//Handle for Contact US
- (void)handleMenuSelectionForContact:(int)index
{
    
    if(index == 0)//Home Editing Screen
    {
        [Utility makeACallWithPhoneNumber:kPhoneNumber];
    }
}


- (void)updateNavigationItems
{
    [self configureMenuItems];
    [mTableView reloadData];
}


#pragma mark - Navigation Section Delegate

-  (void)userDidTapedOnSectionForTitle:(NSString *)title onView:(MenuSectionView *)sectionView
{
    //Find Index Tapped
    int index = 0;
    
    for(NavigationWrapper *wrapper in sectionArray)
    {
       if([wrapper.title isEqualToString:title])
       {
           break;
       }
       else
       {
           index++;
       }
    }

       [self sectionButtonTappedAtIndex:index];
}


- (void)sectionButtonTappedAtIndex:(int)index
{
    if(index == 0 || index == 3)
   {
      if(index == 0)
      {
          [self closeNavigationDrawer];
      }
      else
      {
          //Logout User
          [self closeNavigationDrawer];
          [[DataManager sharedDataManager] logOutUser];
          [self.menuContainerViewController.centerViewController popToRootViewControllerAnimated:NO];
          
        [self presetLoginScreen];
          [self updateNavigationItems];
      }
   }
   else
    {
        NavigationWrapper *wrapper = [sectionArray objectAtIndex:index];
        
        //If Option is already open Close it
        if(!wrapper.isOpen)
        {
            wrapper.isOpen = YES;
        }
        else
        {
            wrapper.isOpen  = NO;
        }
        
        //Close all other options
        for(NavigationWrapper *wr in sectionArray)
        {
            if(![wr.title isEqualToString:wrapper.title])
                wr.isOpen = NO;
        }
        
        //[mTableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
        
       [mTableView reloadData];

    }
    
}

- (void)closeNavigationDrawer
{
    __weak typeof(self) weakSelf = self;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [weakSelf resetNavigationMenu];
                       });
        
    }];
    
}
@end
