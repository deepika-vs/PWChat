//
//  ContactDetailsVC.h
//  PersonalWebsites
//
//  Created by vectoscalar on 26/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"

@interface ContactDetailsVC : BaseViewController<UIScrollViewDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;

@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UIImageView *emailIcon;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIImageView *phoneIcon;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIImageView *addressIcon;

@property (weak, nonatomic) IBOutlet UITextView *addressTextView;

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@property (weak, nonatomic) IBOutlet UIView *latitudeView;
@property (weak, nonatomic) IBOutlet UIImageView *latitudeIcon;


@property (weak, nonatomic) IBOutlet UIView *longitudeView;
@property (weak, nonatomic) IBOutlet UIImageView *longitudeIcon;

@property (weak, nonatomic) IBOutlet UIButton *latitudeButton;

@property (weak, nonatomic) IBOutlet UIButton *longitudeButton;

//Validation message field.
@property (weak, nonatomic) IBOutlet UILabel *reqEmailMgsLbl;

@property (weak, nonatomic) IBOutlet UILabel *reqPhoneMgsLbl;

@property (weak, nonatomic) IBOutlet UILabel *reqAddressMgsLbl;

@property (weak, nonatomic) IBOutlet UILabel *reqLatMgsLbl;

@property (weak, nonatomic) IBOutlet UILabel *reqLngMgsLbl;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)didPressSelectMapButton:(id)sender;

- (IBAction)userPressedSubmitButton:(id)sender;
@end
