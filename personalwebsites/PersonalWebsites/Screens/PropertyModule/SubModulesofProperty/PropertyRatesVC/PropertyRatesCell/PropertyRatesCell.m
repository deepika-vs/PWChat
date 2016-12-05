//
//  PropertyRatesCell.m
//  PersonalWebsites
//
//  Created by VectoScalar on 15/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "PropertyRatesCell.h"

@implementation PropertyRatesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configureUI];
    // Initialization code
}



- (void)configureUI{
    [Utility addShadowToView:self.rateContentsView];
    
    //Configure delete's button UI & add title.
    [Utility addFAUIOnButton:self.deleteButton andFATitle:kTrashFA andColor:[UIColor redColor] andFont:kFAIconSize];
    
    //Configure edit button UI & add title.
    [Utility addFAUIOnButton:self.editButton andFATitle:kEditFAIcon andColor:kNavColor andFont:kFAIconSize];
    
    [Utility addShadowToView:self.rateContentsView];
}


//Add rate attributes value to cell fields.
- (void)showRateRecordToCell:(RateWrapper *) rateRecord{
    
    [self.seasonLbl setText:rateRecord.season];
    [self.startDateLbl setText:rateRecord.startDate];
    [self.endDateLbl setText:rateRecord.endDate];
    
    [self.wkNightRateLbl setText:[NSString stringWithFormat:@"$%@", rateRecord.wkNightRate]];
    [self.wkEndNightRateLbl setText:[NSString stringWithFormat:@"$%@", rateRecord.wkdNihtRate]];
    [self.weeklyRateLbl setText:[NSString stringWithFormat:@"$%@", rateRecord.weeklyNightRate]];
    [self.monthlyRateLbl setText:[NSString stringWithFormat:@"$%@", rateRecord.monthlyRate]];
    
    [self.minStayNightsLbl setText:[NSString stringWithFormat:@"%d Nights", [rateRecord.minStay integerValue]]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//Delete a rate record.
- (IBAction)userPressedDtlRateBtn:(UIButton *)sender {
    //Delete cell from table view.
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:kAlertTitle message:kAlertMsg preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle: kAlertDelBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //Delete with confirmation.
        [self.delegate userPressedDeleteBtnOnCell:self];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:kAlertCancelBtbTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //No action on cancel.
    }]];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
}



- (IBAction)userPressedEditRateBtn:(UIButton *)sender {
    //Update rate attributes
    [self.delegate userPressedEditBtnOnCell:self];
}

@end
