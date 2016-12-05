//
//  ReviewWrapper.h
//  PersonalWebsites
//
//  Created by VectoScalar on 11/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReviewWrapper : NSObject

@property (strong,nonatomic) NSString *customerName;

@property (strong,nonatomic) UIImage *customerProfileImg;

@property (strong,nonatomic) NSString *heading;

@property (strong,nonatomic) NSString *propertyName;

@property (strong,nonatomic) NSString *address;

@property (strong,nonatomic) NSString *content;

@property (assign, nonatomic) NSDate *reviewDate;

@end
