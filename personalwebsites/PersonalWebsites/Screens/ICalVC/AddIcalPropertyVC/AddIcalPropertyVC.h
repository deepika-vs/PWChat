//
//  AddIcalPropertyVC.h
//  PersonalWebsites
//
//  Created by vectoscalar on 15/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWButton.h"
#import "PWTextField.h"
#import "IcalLink+CoreDataClass.h"
#import "BaseViewController.h"

@class AddIcalPropertyVC;

@protocol AddIcalPropertyDelegate <NSObject>

- (void)userAddOrUpdateIcalPropertyWithContent:(IcalLink *)wrapper atRowIndex:(NSInteger) index;

@end

@interface AddIcalPropertyVC : BaseViewController


@property (weak, nonatomic) IBOutlet UIView *propertyIDTextView;

@property (weak, nonatomic) IBOutlet UIView *propertyIDView;

@property (weak, nonatomic) IBOutlet UILabel *propertyIDLlb;


@property (weak, nonatomic) IBOutlet UIView *listView;

@property (weak, nonatomic) IBOutlet UILabel *downArrowLabel;
@property (weak, nonatomic) IBOutlet UILabel *listItemLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewToConstraint;

@property (weak, nonatomic) IBOutlet UIView *headingView
;

@property (weak, nonatomic) IBOutlet PWTextField *headingTextField;

@property (weak, nonatomic) IBOutlet UIView *icalView;

@property (weak, nonatomic) IBOutlet PWTextField *icalTextField;

@property (weak, nonatomic) IBOutlet PWButton *submitButton;

@property (assign, nonatomic) NSInteger rowIndex;
@property (assign,nonatomic) IcalPageType icalPageType;
@property (strong,nonatomic) NSString *pageTitle,*icalPropertyId;

@property (weak, nonatomic) IBOutlet UILabel *requiredPropertyMsgLbl;
@property (weak, nonatomic) IBOutlet UILabel *requiredHeadMsgLbl;
@property (weak, nonatomic) IBOutlet UILabel *requiredLinkMsgLbl;


@property (strong, nonatomic) IcalLink *icalLinkRecord;
@property (assign,nonatomic) id <AddIcalPropertyDelegate> delegate;

- (IBAction)userPressedSubmitButton:(id)sender;

@end
