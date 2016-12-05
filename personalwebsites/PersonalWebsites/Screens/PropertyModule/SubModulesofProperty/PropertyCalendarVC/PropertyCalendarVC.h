//
//  PropertyCalendarVC.h
//  PersonalWebsites
//
//  Created by vectoscalar on 14/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWButton.h"
#import "BaseViewController.h"

@interface PropertyCalendarVC : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *calContentView;

//Calender contents tableview.
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (strong, nonatomic) NSCalendar *calendar;

@property (weak, nonatomic) IBOutlet PWButton *checkSlotBtn;

@property (strong, nonatomic) NSMutableArray *monthsRecordList;

@property (strong, nonatomic) NSMutableArray *bookedSlotsList;

@property (strong, nonatomic) NSMutableArray *bookedDatesList;

- (IBAction)userPressedCheckSlotButton:(PWButton *)sender;

- (void)updateMainDataForDate:(NSDate *)date;

@end
