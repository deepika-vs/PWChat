//
//  DropDownMenuView.h
//  PersonalWebsites
//
//  Created by vectoscalar on 17/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropDownMenuView;

@protocol DropDownMenuDelegate <NSObject>

- (void)didUserSelectedMenuOption:(NSString *)selectedOption;

@end

@interface DropDownMenuView : UIView<UITableViewDelegate,UITableViewDataSource>

{
    UIView *mainView;
    UIView *blurView;
    UITableView *tblView;
    NSArray *menuList;
}

- (id)initWithFrame:(CGRect)frame andListViewFrame:(CGRect)listViewFrame andMenuList:(NSArray*)menuArray;

@property (assign,nonatomic) id <DropDownMenuDelegate> delegate;

@end
