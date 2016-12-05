//
//  PropertyAmenitiesVC.h
//  PersonalWebsites
//
//  Created by vectoscalar on 14/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PropertyAmenitiesVC : BaseViewController < UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (strong, nonatomic) NSMutableArray *amenityObjArray;

- (id) parseJsonFileToJsonObject:(NSString *) fileName;

@property (weak, nonatomic) IBOutlet UILabel *addAmenityCatMsg;

@end
