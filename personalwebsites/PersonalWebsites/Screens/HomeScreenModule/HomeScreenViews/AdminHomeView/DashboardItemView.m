//
//  DashboardItemView.m
//  PersonalWebsiteConponentDesign
//
//  Created by VectoScalar on 30/09/16.
//  Copyright © 2016 vs. All rights reserved.
//

#import "DashboardItemView.h"

@implementation DashboardItemView


- (void) createDashboardItem:(UIColor *) color addTitle:(NSString *) title iconName:(NSString *) iconName{
    CGSize viewSize = CGSizeMake(94, 94);
    
    
    CGFloat dashboardCircleDiameter = viewSize.height - (kDashboardItemCaptionSize + 5.0);
    
    if(dashboardCircleDiameter > viewSize.width){
        dashboardCircleDiameter = viewSize.width;
    }
    
    
    CGFloat xPosCircle = (viewSize.width - dashboardCircleDiameter)/2;
    CGFloat yPosCircle = (viewSize.height - dashboardCircleDiameter- kDashboardItemCaptionSize)/2 + 5.0f;
    
    
    //Prepare circle view size.
    CGRect imgViewFrame = CGRectMake(xPosCircle, yPosCircle, dashboardCircleDiameter, dashboardCircleDiameter);
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgViewFrame];
    [self addSubview:imgView];
    
    imgView.backgroundColor = [UIColor greenColor];
    //create circle for image view
    [self createCircularImgView:imgView];
    //Create border for imageview with color.
    [self addBorderToImageView:imgView borderColor:[UIColor orangeColor] andBorderSize:kImgViewCircleBorderSize];
    
    //Add center icon.
    CGFloat xPosIcon = (imgView.bounds.size.width - kDashboardMiddleIconSide) / 2.0;
    CGFloat yPosIcon = (imgView.bounds.size.height - kDashboardMiddleIconSide) / 2.0;
    
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(xPosIcon, yPosIcon, kDashboardMiddleIconSide, kDashboardMiddleIconSide)];
    
    [self addImage:iconImgView andImgFrame:iconName];
    [imgView addSubview:iconImgView];
    
    //add caption
    CGFloat xPosCaption = self.bounds.origin.x;
    CGFloat yPosCaption = imgView.frame.origin.y + imgView.frame.size.height;
    CGFloat widthCaption = viewSize.width;
    UILabel *captionLabel = [[UILabel alloc] initWithFrame: CGRectMake(xPosCaption,
                                                                       yPosCaption,
                                                                       widthCaption,
                                                                       kDashboardItemCaptionSize)];
    
    captionLabel.text = title;
    captionLabel.textAlignment = NSTextAlignmentCenter;
    [captionLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    captionLabel.textColor = [UIColor whiteColor];
    [self addSubview:captionLabel];
}



-(void) addImage: (UIImageView*) imgView andImgFrame:(NSString *) imgName{
    UIImage *image = [UIImage imageNamed:imgName];
    [imgView setImage: image];
}



-(void) createCircularImgView:(UIImageView *) imgView{
    
    imgView.layer.cornerRadius = imgView.frame.size.width/2;
    imgView.layer.masksToBounds = YES;
}



-(void) addBorderToImageView:(UIImageView *) imgView borderColor: (UIColor *) color andBorderSize: (CGFloat) borderSize{
    [imgView.layer setBorderWidth: borderSize];
    [imgView.layer setBorderColor: color.CGColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
