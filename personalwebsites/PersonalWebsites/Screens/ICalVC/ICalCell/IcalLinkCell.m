//
//  IcalLinkCell.m
//  PersonalWebsiteICalLink
//
//  Created by VectoScalar on 04/10/16.
//  Copyright © 2016 vs. All rights reserved.
//

#import "IcalLinkCell.h"

@implementation IcalLinkCell
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 3.0f;

    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    [Utility addShadowToView:self.mTextUIView];
    
    //Add deletebutton.
    [Utility addFAUIOnButton:self.deleteButton andFATitle:kTrashFA andColor:[UIColor redColor] andFont:kFAIconSize];
    
    [Utility addFAUIOnButton:self.editButton andFATitle:kEditFAIcon andColor:kNavColor andFont:kFAIconSize];
}


//Fill data to review cell to display in tableview.

- (void)showIcalLinkRecordToCell:(IcalLink *) icalLinkRecord{
    
    [self.propertyHeadLabel setText:icalLinkRecord.heading];
    [self.propertyIdLabel setText:icalLinkRecord.propertyid];
    [self.icalLinkLabel setText:icalLinkRecord.link];
    
    //Show only first 10 chars of the date's string.
    [self.icalDate setText:[icalLinkRecord.addeddate substringToIndex: 10]];
}


- (IBAction)userPressedEditButton:(id)sender {
    
    [delegate userPressedEditOnCell:self];
}



- (IBAction)userPressedDeleteButton:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:kAlertTitle message:kAlertMsg preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle: kAlertDelBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //Delete with confirmation.
        [delegate userPressedDeleteOnCell:self];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:kAlertCancelBtbTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //No action on cancel.
    }]];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
}



- (void) addShadowAndBorderToCellUI{
    
    self.cellPlayView.layer.shadowOffset = CGSizeMake(0, 10);
    self.cellPlayView.layer.shadowRadius = -2.5f;
    self.cellPlayView.layer.shadowOpacity = 1.0;
    self.cellPlayView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.mTextUIView.layer.borderWidth = 1.0f;
    self.mTextUIView.layer.borderColor = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1.0].CGColor;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
@end
