//
//  IcalLinkWrapper.h
//  PersonalWebsites
//
//  Created by VectoScalar on 12/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IcalLinkWrapper : NSObject

@property (strong, nonatomic) NSString* heading;
@property (strong, nonatomic) NSString* propertyName;
@property (strong, nonatomic) NSString* icalLink;
@property (strong, nonatomic) NSString* propertyId;
@property (strong, nonatomic) NSDate *addDate;

@end
