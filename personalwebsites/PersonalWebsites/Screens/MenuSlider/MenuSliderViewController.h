//
//  MenuSliderViewController.h
//  SportInfo
//
//  Created by VectoScalar on 4/21/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuSectionView.h"

@interface MenuSliderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MenuNavigationSectionDelegate>

{
    UITableView *mTableView;
}

- (void)updateNavigationItems;


- (void)presentHomeScreenAnimated:(BOOL)animated;

- (void)presetLoginScreen;


- (void)presentContactDetailsScreen;
- (void)presentSocialLinksScreen;
- (void)presentHomeEditingScreen;
- (void)presentICalLinkScreen;
- (void)presentProperyPagerScreen;
- (void)presentReviewsScreen;

@end

