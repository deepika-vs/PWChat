//
//  BookedCalendarSlotsTableVC.m
//  PersonalWebsites
//
//  Created by VectoScalar on 24/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "BookedCalendarSlotsTableVC.h"
#include "BookedSlotTableCell.h"

#define kSlotCellHeight        140.0f
#define kBookedSlotTableCellID @"BookedSlotTableCell"

@interface BookedCalendarSlotsTableVC ()<UITableViewDelegate, UITableViewDataSource, BookedSlotTableCellDelegate>

@end

@implementation BookedCalendarSlotsTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.needToShowBackButton = YES;
    [self createNavigationBarLeftItems];
    
    self.navigationItem.title = kPropertyScreenTitle;
    
    //Register nib
    UINib *nib = [UINib nibWithNibName:kBookedSlotTableCellID bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:kBookedSlotTableCellID];
    // Do any additional setup after loading the view from its nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UITableViewDelegate <Methods>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 01;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.slotRecordsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookedSlotTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kBookedSlotTableCellID forIndexPath:indexPath];
    
    if(cell){
        [cell reloadInputViews];
        
        cell.delegate = self;
        
        [cell setCellFieldsWithSlot:[self.slotRecordsList objectAtIndex:indexPath.row]];
    }
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kSlotCellHeight;
}

#pragma mark -BookedSlotTableCellDelegate <Methods>

- (void)deleteRecordCellFromTable:(BookedSlotTableCell *)cell{
    
    NSIndexPath *indexPath = [self.mTableView indexPathForCell:cell];
    
    [self.delegate deleteSlotFromMainRecord:[self.slotRecordsList objectAtIndex:indexPath.row]];
    
    [self.slotRecordsList removeObjectAtIndex:indexPath.row];
    
    [self.mTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
