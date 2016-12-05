//
//  IcalLinkVC.h
//  PersonalWebsiteICalLink
//
//  Created by VectoScalar on 04/10/16.
//  Copyright © 2016 vs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#define kIcalLinkCellKey     @"IcalLinkCell"
#define kIcalLinkTitle       @"Ical Link"

@interface IcalLinkVC : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *icalLinkTableVIew;

@property (strong, readwrite) NSMutableArray *icalLinkInfoList;

@property (weak, nonatomic) IBOutlet UIView *icalAddView;

@end
