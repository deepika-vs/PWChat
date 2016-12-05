//
//  MenuSliderMapper.m
//  SportInfo
//
//  Created by VectoScalar on 4/21/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "MenuSliderMapper.h"


#define kMenuSliderCacheTime 60*60*24
#define kMenuSliderUrl @"menuSlider"


@implementation MenuSliderMapper


+ (NSString *)fileNameForParam:(NSDictionary *)param{

    return @"menuSlider.json";

}



+ (NSString *)urlString{
    
    return [kBaseUrl stringByAppendingString:kMenuSliderUrl];
}



+ (BOOL)allowCaching{
    
    return true;
}


+ (NSTimeInterval)cacheValidityInterval{
    
    return kMenuSliderCacheTime;
}


@end
