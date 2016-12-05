//
//  PropertyRatesVC.h
//  PersonalWebsites
//
//  Created by vectoscalar on 14/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PropertyRatesVC : BaseViewController <UITableViewDelegate , UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *addRateMsgView;
@property (strong, nonatomic) NSMutableArray* ratesList;

@end
