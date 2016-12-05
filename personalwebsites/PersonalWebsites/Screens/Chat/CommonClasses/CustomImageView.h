//
//  CustomImageView.h
//  CarBay
//
//  Created by VectoScalar on 06/09/15.
//  Copyright (c) 2015 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageView : UIImageView
{
    
    UIActivityIndicatorView *_activityIndicatorView;
    
}

- (void)startActivity;

- (void)stopActivity;

@end
