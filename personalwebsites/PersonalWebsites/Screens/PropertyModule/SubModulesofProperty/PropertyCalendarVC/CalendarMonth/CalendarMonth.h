//
//  CalendarMonth.h
//  PersonalWebsites
//
//  Created by VectoScalar on 10/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarMonth : NSObject

@property (assign, nonatomic) NSUInteger monthNumber;

@property (assign, nonatomic) NSUInteger yearNumber;

@property (assign, nonatomic) NSUInteger startWeekDayOfMonth;

@property (strong, nonatomic) NSDate *firstDateOfMonth;

@property (assign, nonatomic) NSRange rangeOfDayInMonth;

//@property (strong, nonatomic) NSMutableArray *bookedDatesInMonths;

@property (strong, nonatomic) NSMutableArray *daysRecordList;


- (id) initWithMonth:(NSInteger)month andYear:(NSInteger)year;

- (NSInteger) getNumberOfDaysInMonth;

- (NSInteger) getMonthNumber;

- (NSInteger) getYearNumber;

@end
