//
//  APIMapper.h
//  CarBay
//
//  Created by VectoScalar on 19/08/15.
//  Copyright (c) 2015 VectoScalar. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "JSONHTTPClient.h"
#import "APIConstants.h"


@class APIMapper, ResultMapper;



//mapper classe
@interface APIMapper : JSONModel{

}




//Funcitons to override in base mapper's classs for cache utitilty
+ (NSString *)fileNameForParam:(NSDictionary *)param;
+ (NSString *)urlString;
+ (BOOL)allowCaching;
+ (NSTimeInterval)cacheValidityInterval;


//No need to override these.
+ (NSString *)apiMapperCahcheDirectoryPath;
+ (NSString *)applicationDocumentsDirectory;
+ (BOOL)cacheValidForParam:(NSDictionary *)param;
+ (NSMutableDictionary *)updateDictWithSecureData:(NSDictionary *)dictionary;


+ (void)deleteChacheData;



@end



