//
//  AdminHomeView.h
//  PersonalWebsites
//
//  Created by vectoscalar on 24/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DashboardItemView.h"
#import "VCFloatingActionButton.h"

@class AdminHomeView;

@protocol AdminHomeViewDelegate <NSObject>

- (void)userDidSelectPagesInDashboardView:(SelectedPageAction)pageType;
- (void)userDidPressedFloatingButtonWithIndex:(int)index;

@end

@interface AdminHomeView : UIView<floatMenuDelegate>

- (void)configureUI;
- (IBAction)userDidPressedFloatingButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;
@property (weak, nonatomic) IBOutlet UIButton *floatingButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *homeViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *homeView;
@property (weak, nonatomic) IBOutlet UIView *propertyView;
@property (weak, nonatomic) IBOutlet UIView *iCalView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContentTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *propertyViewTopConstratin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iCalTopConstratin;
@property (weak, nonatomic) IBOutlet UIView *contactView;
@property (weak, nonatomic) IBOutlet UIView *reviewView;
@property (weak, nonatomic) IBOutlet UIView *socialView;
@property (weak, nonatomic) IBOutlet UIImageView *propertyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *icalImageView;
@property (weak, nonatomic) IBOutlet UIImageView *reviewImageView;

@property (assign,nonatomic) id <AdminHomeViewDelegate> delegate;

@end
