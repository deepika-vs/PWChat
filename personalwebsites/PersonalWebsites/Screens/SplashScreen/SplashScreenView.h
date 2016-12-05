//
//  SplashScreenView.h
//  CarBay
//
//  Created by VectoScalar on 26/08/15.
//  Copyright (c) 2015 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashScreenView : UIView
{
    
    UIImageView *_animationImageView;
    UIImageView *_backgroundImageView;
}

- (void)startAnimation;
- (void)stopAnimation;

@end
