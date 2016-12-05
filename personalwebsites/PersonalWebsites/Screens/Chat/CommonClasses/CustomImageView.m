//
//  CustomImageView.m
//  CarBay
//
//  Created by VectoScalar on 06/09/15.
//  Copyright (c) 2015 VectoScalar. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

- (void)startActivity{
    
    
    //CBLog(@"startActivity");
    if(!_activityIndicatorView){
        
        _activityIndicatorView= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.frame = CGRectMake(0, 0, 50, 50);
        _activityIndicatorView.hidesWhenStopped = YES;
        self.userInteractionEnabled = NO;
        
        _activityIndicatorView.backgroundColor = [UIColor clearColor];
        _activityIndicatorView.frame = CGRectMake(self.frame.size.width/2 - _activityIndicatorView.frame.size.width/2,
                                                          self.frame.size.height/2 - _activityIndicatorView.frame.size.height/2,
                                                          _activityIndicatorView.frame.size.width,
                                                          _activityIndicatorView.frame.size.height);
        
    }
    
    
    [self addSubview:_activityIndicatorView];
    [_activityIndicatorView startAnimating];
    
    
}


- (void)stopActivity{
    
    //CBLog(@"Stop Activity");
    [_activityIndicatorView stopAnimating];
    
    [_activityIndicatorView removeFromSuperview];
    
}


@end
