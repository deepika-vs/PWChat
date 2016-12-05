//
//  CalendarBookedSlot.h
//  PersonalWebsites
//
//  Created by VectoScalar on 16/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarBookedSlot : NSObject

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *email;

@property (strong, nonatomic) NSDate *firstDate;

@property (strong, nonatomic) NSDate *lastDate;

@property (strong, nonatomic) NSDate *bookedDate;

-(id) initWithName:(NSString *) userName andEmail:(NSString *)email;

@end
