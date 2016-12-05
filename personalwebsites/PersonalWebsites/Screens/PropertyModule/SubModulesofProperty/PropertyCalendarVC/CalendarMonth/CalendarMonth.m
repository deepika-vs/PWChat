//
//  CalendarMonth.m
//  PersonalWebsites
//
//  Created by VectoScalar on 10/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "CalendarMonth.h"

@implementation CalendarMonth

- (id) initWithMonth:(NSInteger)month andYear:(NSInteger)year{
    self = [super init];
    
    if(self){
        self.monthNumber = month;
        self.yearNumber = year;
        
        self.firstDateOfMonth = [Utility createDateWithDay:01 andMonth:month andYear:year];
        
        self.startWeekDayOfMonth = [[NSCalendar currentCalendar] component:NSCalendarUnitWeekday
                                                                  fromDate:self.firstDateOfMonth];
        
        self.rangeOfDayInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay
                                                                    inUnit:NSCalendarUnitMonth
                                                                   forDate:self.firstDateOfMonth];
        
        self.daysRecordList = [[NSMutableArray alloc] init];
    }
    
    return self;
}



- (NSInteger) getNumberOfDaysInMonth{
    
    return self.rangeOfDayInMonth.length;
}


- (NSInteger) getMonthNumber{
    
    return self.monthNumber;
}


- (NSInteger) getYearNumber{
    
    return self.yearNumber;
}



- (BOOL) isSlotBookedForDateInRange:(NSRange) range{
    
//    NSInteger nBookedSlot = [self.selectedSlotsInMonths count];
//    
//    for(NSInteger i=0; i< nBookedSlot; i++){
//        NSRange bookedSlot = NSMakeRange(25, 31);
//        //(NSRange) [self.selectedSlotsInMonths objectAtIndex:i];
//        
//        NSRange intersectionRange = NSIntersectionRange(range , bookedSlot);
//        
//        if((intersectionRange.length - intersectionRange.location) > 0)
//        {
//            return YES;
//        }
//    }
    return NO;
}
@end
