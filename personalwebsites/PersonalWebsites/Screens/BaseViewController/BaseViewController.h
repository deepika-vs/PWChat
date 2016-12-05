//
//  BaseViewController.h
//  SportInfo
//
//  Created by VectoScalar on 4/21/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"
#import "MFSideMenu.h"

@interface BaseViewController : UIViewController<APIManagerDelegate>

@property(nonatomic, strong) APIManager *apiManager;
@property (assign,nonatomic) BOOL needToShowBackButton;
@property (assign,nonatomic) BOOL needToShowRightBavItem;
@property (strong, nonatomic) UIViewController *containerVC;

- (void)hideNavigationBackButton;
- (void)createNavigationBarLeftItems;
//- (void)createRightNavigationItemsForGuestHomeScreen;
- (void)createRightNavigationItem:(NSString *) titleFAStr andSize:(CGFloat) size;
- (void)createFloatingButton;

- (void)removeRightNavItem;
- (void)hideRightNavigationItem;
- (void)showRightNavigationItem;



@end
