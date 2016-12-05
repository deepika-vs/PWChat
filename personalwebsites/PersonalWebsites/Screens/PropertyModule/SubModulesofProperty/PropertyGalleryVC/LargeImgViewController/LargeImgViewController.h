//
//  LargeImgViewController.h
//  PersonalWebsites
//
//  Created by VectoScalar on 18/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "BaseViewController.h"

@interface LargeImgViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (strong, nonatomic) NSMutableArray *imagesList;
@property (assign, nonatomic) NSInteger imgIndex;

@end
