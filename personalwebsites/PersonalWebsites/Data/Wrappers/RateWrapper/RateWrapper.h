//
//  RateWrapper.h
//  PersonalWebsites
//
//  Created by VectoScalar on 22/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RateWrapper : NSObject
@property (strong, nonatomic) NSString *season;
@property (strong, nonatomic) NSString *wkNightRate;
@property (strong, nonatomic) NSString *wkdNihtRate;
@property (strong, nonatomic) NSString *weeklyNightRate;
@property (strong, nonatomic) NSString *monthlyRate;
@property (strong, nonatomic) NSString *startDate;
@property (strong, nonatomic) NSString *endDate;
@property (strong, nonatomic) NSString *minStay;
@end
