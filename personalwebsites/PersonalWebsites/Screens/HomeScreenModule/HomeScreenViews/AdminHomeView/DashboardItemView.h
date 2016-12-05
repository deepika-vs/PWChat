//
//  DashboardItemView.h
//  PersonalWebsiteConponentDesign
//
//  Created by VectoScalar on 30/09/16.
//  Copyright © 2016 vs. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kDashboardMiddleIconSide 20.0f
#define kDashboardItemCaptionSize 30.0f
#define kImgViewCircleBorderSize 2.0f


@interface DashboardItemView : UIView
- (void) createDashboardItem:(UIColor *) color addTitle:(NSString *) title iconName:(NSString *) iconName;
@end
