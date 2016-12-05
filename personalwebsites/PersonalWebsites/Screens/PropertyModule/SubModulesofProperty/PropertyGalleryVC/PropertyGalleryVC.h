//
//  PropertyGalleryVC.h
//  PersonalWebsites
//
//  Created by vectoscalar on 14/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface PropertyGalleryVC : BaseViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *imagesList;
@property (strong, nonatomic) NSMutableArray *imgCaptionList;

@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;

@property (weak, nonatomic) IBOutlet UILabel *addNewImgLbl;

@property (weak, nonatomic) IBOutlet UIView *addImageMsgView;

@end
