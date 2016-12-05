//
//  AddAmenituView.h
//  PersonalWebsites
//
//  Created by vectoscalar on 26/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddAmenituView;

@protocol AddAmenityViewDelegate <NSObject>

- (void)didUserAddedAmenity:(NSString *)content onView:(AddAmenituView *)view;

@end

@interface AddAmenituView : UIView
{
    UIView *mainView;
    UITextField *textField;
    NSString *headingTitle,*placeholder,*submitButtonTitle;
    
}

- (id)initWithTitle:(NSString *)title andPlaceholder:(NSString*)placeholderTitle andBtnTitle:(NSString*)buttonTitle;

@property (assign,nonatomic) id <AddAmenityViewDelegate> delegate;

@end
