//
//  DataManager.h
//  CarBay
//
//  Created by VectoScalar on 20/08/15.
//  Copyright (c) 2015 VectoScalar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIMapper.h"



@class APIManager;


#define kAPIMethodTypeGET @"GET"
#define kAPIMethodTypePOST @"POST"


@protocol APIManagerDelegate <NSObject>

- (void)manager:(APIManager *)manager didFinishedForMapper:(APIMapper *)mapper;
- (void)manager:(APIManager *)manager didFailedForMapper:(APIMapper *)mapper;

@end

@interface APIManager : NSObject

@property (weak, nonatomic) id<APIManagerDelegate> delegate;

- (void)getServerDataWithParam:(NSDictionary *)params apiMethodType:(NSString *)methodType andMapperClass:(Class)mapperClass;


@end
