//
//  CalendarDayViewCell.h
//  PersonalWebsites
//
//  Created by VectoScalar on 09/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarMonthDay.h"

#define kCalDayCellHeight 45.0f

@interface CalendarDayCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *dayContentsView;

@property (weak, nonatomic) IBOutlet UILabel *dayDateLabel;

@property (strong, nonatomic) CalendarMonthDay *day;

- (void) initCellWithDefaultValues;

- (void) setDayContents:(NSInteger) dayForDate;

- (void) updateDayRecord:(CalendarMonthDay *)dayRecord;

- (void)updateBookedSelection;

- (void)updateSelection;

- (void)updateColorOfCellBG: (UIColor *) color andTextColor: (UIColor *) textColor;

@end
