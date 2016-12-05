//
//  IcalLinkCell.h
//  PersonalWebsiteICalLink
//
//  Created by VectoScalar on 04/10/16.
//  Copyright © 2016 vs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IcalLink+CoreDataProperties.h"

@class IcalLinkCell;

@protocol ICalCellDelegate <NSObject>

- (void)userPressedEditOnCell:(IcalLinkCell*)cell;
- (void)userPressedDeleteOnCell:(IcalLinkCell*)cell;


@end

@interface IcalLinkCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *mTextUIView;


@property (weak, nonatomic) IBOutlet UILabel *propertyIdLabel;

@property (weak, nonatomic) IBOutlet UILabel *propertyHeadLabel;

@property (weak, nonatomic) IBOutlet UILabel *icalLinkLabel;

@property (weak, nonatomic) IBOutlet UILabel *icalDate;
@property (weak, nonatomic) IBOutlet UIView *cellPlayView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (assign,nonatomic) id <ICalCellDelegate> delegate;

- (void) addShadowAndBorderToCellUI;

- (IBAction)userPressedEditButton:(id)sender;

- (IBAction)userPressedDeleteButton:(UIButton *)sender;

- (void)showIcalLinkRecordToCell:(IcalLink *) wrapperContent;

@end
