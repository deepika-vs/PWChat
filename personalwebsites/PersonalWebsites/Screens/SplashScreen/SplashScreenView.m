//
//  SplashScreenView.m
//  CarBay
//
//  Created by VectoScalar on 26/08/15.
//  Copyright (c) 2015 VectoScalar. All rights reserved.
//

#import "SplashScreenView.h"

@implementation SplashScreenView


- (id)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];

    
    if(self){
        
        
        
        
        
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                             0,
                                                                             self.frame.size.width/2.5,
                                                                             self.frame.size.width/2.5)];
        _backgroundImageView.center = self.center;
        _backgroundImageView.backgroundColor = [UIColor colorWithRed:6.0/255.0f green:217.0/255.0f blue:147.0/255.0f alpha:1.0];
        _backgroundImageView.layer.cornerRadius = (self.frame.size.width/2.5)/2;
        UIImage *image = [UIImage imageNamed:@"logo"];
        _backgroundImageView.clipsToBounds = YES;
        _backgroundImageView.image = image;
        
        [self addSubview:_backgroundImageView];
        
        
        
        ////////////
        
        
//        UIInterpolatingMotionEffect *verticalMotionEffect =
//        [[UIInterpolatingMotionEffect alloc]
//         initWithKeyPath:@"center.y"
//         type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
//        verticalMotionEffect.minimumRelativeValue = @(-20);
//        verticalMotionEffect.maximumRelativeValue = @(20);
//        
//        // Set horizontal effect
//        UIInterpolatingMotionEffect *horizontalMotionEffect =
//        [[UIInterpolatingMotionEffect alloc]
//         initWithKeyPath:@"center.x"
//         type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
//        horizontalMotionEffect.minimumRelativeValue = @(-20);
//        horizontalMotionEffect.maximumRelativeValue = @(20);
//        
//        // Create group to combine both
//        UIMotionEffectGroup *group = [UIMotionEffectGroup new];
//        group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
//        
//        // Add both effects to your view
//        [_backgroundImageView addMotionEffect:group];
        
        
        /////////////
        
        
        
        
        
        //_animationImageView = [[UIImageView alloc]init];
        
       // _animationImageView.frame = CGRectMake(20, self.frame.size.height/2-20, self.frame.size.width-40, 40);
      //  _animationImageView.image = [UIImage imageNamed:@"LogoSelectionScreen.png"];
        /*
        _animationImageView.animationImages = [NSArray arrayWithObjects:
                                               [UIImage imageNamed:@"splash_frame_01.png"],
                                               [UIImage imageNamed:@"splash_frame_02.png"],
                                               [UIImage imageNamed:@"splash_frame_03.png"],
                                               [UIImage imageNamed:@"splash_frame_04.png"],
                                               [UIImage imageNamed:@"splash_frame_05.png"],
                                               [UIImage imageNamed:@"splash_frame_06.png"],
                                               [UIImage imageNamed:@"splash_frame_07.png"],
                                               [UIImage imageNamed:@"splash_frame_08.png"],
                                               [UIImage imageNamed:@"splash_frame_09.png"],
                                               [UIImage imageNamed:@"splash_frame_10.png"],
                                               [UIImage imageNamed:@"splash_frame_11.png"],
                                               [UIImage imageNamed:@"splash_frame_12.png"],
                                               [UIImage imageNamed:@"splash_frame_13.png"],
                                               [UIImage imageNamed:@"splash_frame_14.png"],
                                               [UIImage imageNamed:@"splash_frame_15.png"],
                                               [UIImage imageNamed:@"splash_frame_16.png"],
                                             nil];
        _animationImageView.tag = 1;
        _animationImageView.animationDuration = 1.0f;
        _animationImageView.animationRepeatCount = 0;
        _animationImageView.backgroundColor = [UIColor clearColor];
        
        _animationImageView.frame = CGRectMake(self.frame.size.width/2 - _animationImageView.frame.size.width/2,
                                                self.frame.size.height/2 - _animationImageView.frame.size.height/2,
                                                _animationImageView.frame.size.width,
                                                _animationImageView.frame.size.height);
         */
        
      //  [self addSubview:_animationImageView];
    }
    
    
    return self;
}


- (void)startAnimation{
    
    [_animationImageView startAnimating];
}



- (void)stopAnimation{
    
     [_animationImageView stopAnimating];
    
}


@end
