//
//  PropertyRatesCell.h
//  PersonalWebsites
//
//  Created by VectoScalar on 15/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateWrapper.h"

@class PropertyRatesCell;

@protocol PropertyRatesCellDelegate <NSObject>

- (void)userPressedEditBtnOnCell:(PropertyRatesCell *)cell;
- (void)userPressedDeleteBtnOnCell:(PropertyRatesCell *)cell;

@end

@interface PropertyRatesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *rateContentsView;

@property (weak, nonatomic) IBOutlet UILabel *seasonLbl;

@property (weak, nonatomic) IBOutlet UILabel *startDateLbl;

@property (weak, nonatomic) IBOutlet UILabel *endDateLbl;

@property (weak, nonatomic) IBOutlet UILabel *wkNightRateLbl;

@property (weak, nonatomic) IBOutlet UILabel *wkEndNightRateLbl;

@property (weak, nonatomic) IBOutlet UILabel *weeklyRateLbl;

@property (weak, nonatomic) IBOutlet UILabel *monthlyRateLbl;

@property (weak, nonatomic) IBOutlet UILabel *minStayNightsLbl;

@property (assign, nonatomic) id<PropertyRatesCellDelegate> delegate;

//Set uiview.
- (void)configureUI;

//Add buttons outlets & action.
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

- (IBAction)userPressedDtlRateBtn:(UIButton *)sender;
- (IBAction)userPressedEditRateBtn:(UIButton *)sender;

- (void)showRateRecordToCell:(RateWrapper *) rateRecord;

@end
