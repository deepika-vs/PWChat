//
//  CalendarBookedSlot.m
//  PersonalWebsites
//
//  Created by VectoScalar on 16/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "CalendarBookedSlot.h"

@implementation CalendarBookedSlot

-(id) initWithName:(NSString *) userName andEmail:(NSString *)email{
    self = [super init];
    
    if(self){
        self.name = userName;
        self.email = email;
        self.bookedDate = [NSDate date];
    }

    return self;
}
@end
