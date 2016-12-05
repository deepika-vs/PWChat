//
//  DataManager.m
//  CarBay
//
//  Created by VectoScalar on 20/08/15.
//  Copyright (c) 2015 VectoScalar. All rights reserved.
//

#import "APIManager.h"
#import "Reachability.h"


@implementation APIManager



- (void)getServerDataWithParam:(NSDictionary *)params apiMethodType:(NSString *)methodType andMapperClass:(Class)mapperClass
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if(![mapperClass isSubclassOfClass:[APIMapper class]]){
            
            DebugLog(@"Mapper is not a subclass of APIMapper");
            [self showDownloadFailureAlert];
            [self.delegate manager:self didFailedForMapper:nil];
            return;
            
        }
        
        
        if(![mapperClass urlString]){
            
            DebugLog(@"Mapper does not have url string");
            [self showDownloadFailureAlert];
            [self.delegate manager:self didFailedForMapper:nil];
            return;
        }
        
        
        
        
        
        //Set Global params
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:params];
        
        
        
        NSString *bodyString = nil;
        //        if([paramDict valueForKey:kAPIBodyKey])
        //        {
        //            bodyString = [paramDict valueForKey:kAPIBodyKey];
        //            [paramDict removeObjectForKey:kAPIBodyKey];
        //        }
        
        
        
        
        
        
        //Check cache
        NSString *filePath = [[mapperClass apiMapperCahcheDirectoryPath] stringByAppendingPathComponent:[mapperClass fileNameForParam:paramDict]];
        
        if([mapperClass cacheValidForParam:paramDict]){
            
            //Cahche is valid, read from file
            JSONModelError *error;
            APIMapper *mapper = [[mapperClass alloc] initWithString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil]
                                                              error:&error];
            
            if(!error)
            {
                DebugLog(@"Loading from cache file");
                [self.delegate manager:self didFinishedForMapper:mapper];
                return;
                
            }
        }
        
        
        
        //Still here means cache is not valid or corrupt
        
        //Check internet before making call
        NSString *hostName = [[NSURL URLWithString:kBaseUrl] host];
        Reachability *r = [Reachability reachabilityWithHostName:hostName];
        
        if(NotReachable == [r currentReachabilityStatus]) {
            
            //Prompt User
            
            [self.delegate manager:self didFailedForMapper:nil];
            
            return;
        }
        
        
        NSString *urlToUse = [mapperClass urlString]; //stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        
        //Set header
        [[JSONHTTPClient requestHeaders] setValue:@"accept-encoding" forKey:@"gzip"];
        
        DebugLog(@"Url = %@", urlToUse);
    
        
        [JSONHTTPClient JSONFromURLWithString:urlToUse
                                       method:methodType
                                       params:[mapperClass updateDictWithSecureData:paramDict]
                                 orBodyString:bodyString
                                   completion:^(id json, JSONModelError *err) {
                                       
                                       
                                       if(err == nil)
                                       {
                                           
                                           if(json && [json isKindOfClass:[NSDictionary class]]){
                                               
                                               
                                               JSONModelError *error;
                                               
                                               APIMapper *mapper = [[mapperClass alloc] initWithDictionary:json error:&error];
                                               
                                               
                                               if(!error && mapper)
                                               {
                                                   //mapper created
                                                   if([mapperClass allowCaching] && [mapperClass cacheValidityInterval] > 0){
                                                       
                                                       [[mapper toJSONString] writeToFile:filePath
                                                                               atomically:true
                                                                                 encoding:NSUTF8StringEncoding
                                                                                    error:nil];
                                                   }
                                                   
                                                   
                                                   [self.delegate manager:self didFinishedForMapper:mapper];
                                                   
                                                   return;
                                                   
                                               }
          
                                               
                                           }
                                           
                                           
                                           
                                       }

                                       [self showDownloadFailureAlert];
                                       [self.delegate manager:self didFailedForMapper:nil];
                                       
                                   }];
        
        
    });
    
    
}




- (void)dealloc{
    
    self.delegate = nil;
}




- (void)showDownloadFailureAlert{

    
}


@end
