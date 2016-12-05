//
//  BaseViewController.h
//  SportInfo
//
//  Created by VectoScalar on 4/21/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MessagingHeaderView.h"
#import "ChatAccessor.h"


@interface BaseViewController : UIViewController{
    UILabel *_screenTitleLabel;
}


@property(nonatomic, assign) BOOL needToHideBackButton;
@property(nonatomic, strong) NSString *screenTitle;
@property (nonnull,strong) UIView *floatingView;
@property (strong,nonatomic)  MessagingHeaderView *navTitleView;
@property (assign,nonatomic) CGRect visbleFrame;


- (void)showProgressView;
- (void)hideProgressView;
- (void)createNavigationBarLeftItemsView;
- (void)createNavigationTitleViewWithTitle:(nonnull NSString* )title andSubtitle:(nonnull NSString*)subTitle;
-(void)getPurpleStatusViewForNavBar:(nonnull UINavigationBar *)navBar;
//-(void)removeStatusViewForNavBar:(nonnull UINavigationBar *)navBar;

- (void)createFloatingViewWithBadgeCount;
- (void)createUserChatImageAndStatusView;

- (void)hideMessageCount;

- (void)openMessageControllerViaNavigationController;
- (void)openMessageController;
- (void)configureBadgeLabel;
@end
