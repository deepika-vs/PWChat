//
//  BookedSlotTableCell.h
//  PersonalWebsites
//
//  Created by VectoScalar on 24/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarBookedSlot.h"

@class BookedSlotTableCell;

@protocol BookedSlotTableCellDelegate <NSObject>

- (void)deleteRecordCellFromTable:(BookedSlotTableCell *)cell;

@end

@interface BookedSlotTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *contentsView;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *firstDate;
@property (weak, nonatomic) IBOutlet UILabel *lastDate;
@property (weak, nonatomic) IBOutlet UILabel *addedDate;

@property (assign, nonatomic) id <BookedSlotTableCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
- (IBAction)userPressedDeleteButton:(UIButton *)sender;

- (void)setCellFieldsWithSlot:(CalendarBookedSlot *)slot;

@end
