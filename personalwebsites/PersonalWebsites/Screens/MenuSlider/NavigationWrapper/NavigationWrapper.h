//
//  NavigationWrapper.h
//  PersonalWebsites
//
//  Created by vectoscalar on 30/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NavigationSubRows.h"

@interface NavigationWrapper : NSObject

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *iconName;
@property (assign,nonatomic) BOOL isOpen;
@property (strong,nonatomic) NSArray<NavigationSubRows*> *rows;

@end
