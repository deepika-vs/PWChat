//
//  CalendarMonthDay.m
//  PersonalWebsites
//
//  Created by VectoScalar on 10/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "CalendarMonthDay.h"

@implementation CalendarMonthDay
- (id) initWithDay: (NSInteger)day andMonth:(NSInteger)month andYear:(NSInteger) year{
    self = [super init];
    
    if(self){
        self.date = [Utility createDateWithDay:day andMonth:month andYear:year];
        self.dayNumDate = day;
        
        self.isBooked = NO;
        self.isSelected = NO;
    }
    
    return self;
}

@end
