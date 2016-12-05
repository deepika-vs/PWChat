//
//  PropertryCalendarCell.h
//  PersonalWebsites
//
//  Created by VectoScalar on 09/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarMonth.h"
#import "BookSlotFormView.h"

@class CalendarMonthTableViewCell;

@protocol CalendarMonthTableViewCellDelegate <NSObject>
- (BOOL) isDateBooked:(NSDate *) date;
- (void) addSlotToList: (CalendarBookedSlot *) slot;
- (void) reloadTableView; //It may be remove.
- (NSDate *)getSelectedFirstDate;
- (void)setSelectedFirstDate:(NSDate *) firstDate;
@end


@interface CalendarMonthTableViewCell : UITableViewCell < UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *monthHeaderView;

@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;

@property (strong, nonatomic) CalendarMonth *month;

@property (assign, nonatomic) id <CalendarMonthTableViewCellDelegate> delegate;

- (NSInteger)getDateForTheDay:(NSInteger) rowNum;

- (void)resetSubviews;

@end
