//
//  APIMapper.m
//  CarBay
//
//  Created by VectoScalar on 19/08/15.
//  Copyright (c) 2015 VectoScalar. All rights reserved.
//

//
//  VHAPIMapper.m
//  CarDekhoApp
//
//  Created by vs on 31/07/15.
//  Copyright (c) 2015 vs. All rights reserved.
//

#import "APIMapper.h"
#import "AppDelegate.h"
#import "Reachability.h"
@implementation APIMapper



- (id)init{
    
    self = [super init];
    
    if(self){
        
    }
    
    return self;
}



+ (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}


+ (NSString *)apiMapperCahcheDirectoryPath
{
    NSString *directoryPath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"MapperCache"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:directoryPath] == false){
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:true attributes:nil error:nil];
    }
    
    return directoryPath;
}



+ (NSString *)fileNameForParam:(NSDictionary *)param{
    return nil;
}



+ (NSString *)urlString{
    
    return kBaseUrl;
}



+ (BOOL)allowCaching{
    
    return false;
}


+ (NSTimeInterval)cacheValidityInterval{
    return 0;
}



+ (BOOL)cacheValidForParam:(NSDictionary *)param
{
    
    if(![self allowCaching]){
        //caching not allowed
        return false;
    }
    
    
    NSString *filePath = [[self apiMapperCahcheDirectoryPath] stringByAppendingPathComponent:[self fileNameForParam:param]];
    DebugLog(@"Filepath:%@", filePath);
    

    NSFileManager *manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:filePath]){
        
        //IS a file and exist
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        NSDate *fileDate = nil;
        
        NSError *error;
        [fileUrl getResourceValue:&fileDate forKey:NSURLContentModificationDateKey error:&error];
        if (!error)
        {
            if([[NSDate date] timeIntervalSinceDate:fileDate] <= [self cacheValidityInterval]){
                return true;
            }
        }
        
    }
    else{
        DebugLog(@"File not exist");
    }
    
    
    return false;
}



+ (NSMutableDictionary *)updateDictWithSecureData:(NSDictionary *)dictionary{
    
    //TODO: Check we need any security?
    
//    NSMutableDictionary *finalDict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
//    
//    NSArray *array = [NSArray arrayWithObjects:@"userId", @"passwordStatus", @"mobile_number", @"emp_id", @"email_id", @"completeapp", nil];
//    
//    for (NSString *key in [finalDict allKeys]) {
//        
//        if([array containsObject:key]){
//            [finalDict setValue:[VGCryptoUtils encryptedStringForString:[dictionary objectForKey:key] error:nil] forKey:key];
//        }
//        
//    }
    //CBLog(@"Param:%@", dictionary);
    return [NSMutableDictionary dictionaryWithDictionary:dictionary];
}



+ (void)deleteChacheData{
    
    
    NSString *path  = [self apiMapperCahcheDirectoryPath];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    NSArray *fileArray = [fileMgr contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *filename in fileArray)  {
        
        [fileMgr removeItemAtPath:[path stringByAppendingPathComponent:filename] error:NULL];
        
        DebugLog(@"Deleting file at path = %@", [path stringByAppendingPathComponent:filename]);
    }
    
    
}











@end
