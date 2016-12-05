//
//  BookedSlotTableCell.m
//  PersonalWebsites
//
//  Created by VectoScalar on 24/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "BookedSlotTableCell.h"

@implementation BookedSlotTableCell
//@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [Utility addShadowToView:self.contentView];
 
    //Add deletebutton.
    [Utility addFAUIOnButton:self.deleteButton andFATitle:kTrashFA andColor:[UIColor redColor] andFont:kFAIconSize];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setCellFieldsWithSlot:(CalendarBookedSlot *)slot{
    [self.userName setText:[slot.name uppercaseString]];
    [self.email setText:slot.email];
   
    NSString *addedDateStr = [[NSString stringWithFormat:@"%@",slot.bookedDate] substringWithRange:NSMakeRange(0, 10)];
    [self.addedDate setText:addedDateStr];
    
    NSString *firstDateStr = [[NSString stringWithFormat:@"%@",slot.firstDate] substringWithRange:NSMakeRange(0, 10)];
    [self.firstDate setText:firstDateStr];
    
    NSString *lastDateStr = [[NSString stringWithFormat:@"%@",slot.lastDate] substringWithRange:NSMakeRange(0, 10)];
    [self.firstDate setText:lastDateStr];
}

- (IBAction)userPressedDeleteButton:(UIButton *)sender {
    [self.delegate deleteRecordCellFromTable:self];
}
@end
