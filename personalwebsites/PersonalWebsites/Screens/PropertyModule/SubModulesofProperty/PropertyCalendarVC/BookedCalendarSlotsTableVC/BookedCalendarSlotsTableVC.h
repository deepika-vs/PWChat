//
//  BookedCalendarSlotsTableVC.h
//  PersonalWebsites
//
//  Created by VectoScalar on 24/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CalendarBookedSlot.h"

@class BookedCalendarSlotsTableVC;

@protocol BookedCalendarSlotsTableVCDelegate <NSObject>

- (void)deleteSlotFromMainRecord:(CalendarBookedSlot *) slot;

@end


@interface BookedCalendarSlotsTableVC : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) IBOutlet NSMutableArray *slotRecordsList;

@property (assign, nonatomic) id<BookedCalendarSlotsTableVCDelegate> delegate;
@end
