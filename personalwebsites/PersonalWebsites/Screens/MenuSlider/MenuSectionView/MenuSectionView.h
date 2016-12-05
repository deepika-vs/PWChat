//
//  MenuSectionView.h
//  PersonalWebsites
//
//  Created by vectoscalar on 30/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuSectionView;

@protocol MenuNavigationSectionDelegate <NSObject>

- (void)userDidTapedOnSectionForTitle:(NSString *)title onView:(MenuSectionView *)sectionView;

@end

@interface MenuSectionView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *sectionImage;
@property (weak, nonatomic) IBOutlet UILabel *sectionTitle;
@property (weak, nonatomic) IBOutlet UIView *sectionView;
@property (weak, nonatomic) IBOutlet UILabel *accessoryIcon;

@property (assign,nonatomic) id <MenuNavigationSectionDelegate> delegate;

- (void)updateSectionMenuWithTitle:(NSString *)title andImageName:(NSString*)imgName;
- (void)updateAccessorView;

- (void)updateAccessorViewWithDownArrow;

@end
