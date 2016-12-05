//
//  CalendarMonthDay.h
//  PersonalWebsites
//
//  Created by VectoScalar on 10/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarMonthDay : NSObject

@property (assign, nonatomic) NSUInteger dayNumDate;

@property (assign, nonatomic) BOOL isSelected;

@property (assign, nonatomic) BOOL isBooked;

@property (strong, nonatomic) NSDate *date;

- (id) initWithDay: (NSInteger)day andMonth:(NSInteger)month andYear:(NSInteger) year;
@end
