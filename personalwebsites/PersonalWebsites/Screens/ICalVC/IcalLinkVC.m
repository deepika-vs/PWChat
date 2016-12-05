//
//  IcalLinkVC.m
//  PersonalWebsiteICalLink
//
//  Created by VectoScalar on 04/10/16.
//  Copyright © 2016 vs. All rights reserved.
//

#import "IcalLinkVC.h"
#import "IcalLinkCell.h"
#import "AddIcalPropertyVC.h"


#define kAddIcalNib @"AddIcalPropertyVC"

#define kNavigationButtonFont 22

@interface IcalLinkVC ()<AddIcalPropertyDelegate,ICalCellDelegate>

@end

@implementation IcalLinkVC

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.needToShowBackButton = YES;
    [self createNavigationBarLeftItems];
    self.navigationItem.title = kIcalLinkTitle;
    
    
    //Set delegate.
    self.icalLinkTableVIew.delegate = self;
    self.icalLinkTableVIew.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:kIcalLinkCellKey bundle:nil];
    [self.icalLinkTableVIew registerNib:nib forCellReuseIdentifier:kIcalLinkCellKey];
    
    [self customizeTableView];
    
    self.icalLinkTableVIew.estimatedRowHeight = 80;
    self.icalLinkTableVIew.rowHeight = UITableViewAutomaticDimension;
    
    
    [self performSelector:@selector(createFloatingButton) withObject:nil afterDelay:0.01];
    // Do any additional setup after loading the view from its nib.
    
    //Fetch data from persistance store.
    [self fetchDataFromPersistenceStore];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


-(void) customizeTableView{
    self.icalLinkTableVIew.backgroundColor = [UIColor clearColor];
    self.icalLinkTableVIew.opaque = NO;
    self.icalLinkTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
}



- (void)fetchDataFromPersistenceStore
{
    if(!self.icalLinkInfoList){
        self.icalLinkInfoList = [[NSMutableArray alloc] init];
    }
    
    self.icalLinkInfoList = [DataManager getModelEntityData:kIcalLinkEntiry];
}




- (void)hideTableView
{
    self.icalLinkTableVIew.hidden = YES;
    self.icalAddView.hidden = NO;
}


- (void)showTableView
{
    self.icalLinkTableVIew.hidden = NO;
    self.icalAddView.hidden = YES;
}



#pragma mark - TableView delegate.

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 01;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger nRowsInSec  = [self.icalLinkInfoList count];
    
    [self manageUIBasedOnData:nRowsInSec];
    
    return nRowsInSec;
}



- (void)manageUIBasedOnData:(NSInteger) numRow
{
    if(numRow == 0)
    {
        [self hideTableView];
    }
    else
    {
        [self showTableView];
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IcalLinkCell *cell = [tableView dequeueReusableCellWithIdentifier:kIcalLinkCellKey forIndexPath:indexPath];

    if(cell){
        cell.delegate = self;
        //Check the cell is already created & have its data.
        if([self.icalLinkInfoList count] > indexPath.row){
            
            // Configure the cell...
            IcalLink *icalLinkRecord = [self.icalLinkInfoList objectAtIndex:indexPath.row];
            
            [cell showIcalLinkRecordToCell: icalLinkRecord];
            
        }
        
        //Update ui for the cell.
        [cell addShadowAndBorderToCellUI];
    }
    
    
    return cell;
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}



#pragma mark - Manage Floaing Button

//Add new ical link to tableview.
- (void)floatingButtonTapped
{
    AddIcalPropertyVC *addIcalVC = [[AddIcalPropertyVC alloc] initWithNibName:kAddIcalNib bundle:nil];
    
    addIcalVC.icalLinkRecord = nil;
    
    addIcalVC.rowIndex = [self.icalLinkInfoList count];
    
    addIcalVC.delegate = self;
    
    [self.navigationController pushViewController:addIcalVC animated:YES];
}



#pragma mark- Add Ical Delegate

- (void)userAddOrUpdateIcalPropertyWithContent:(IcalLink *)icalLinkRecord atRowIndex:(NSInteger) index;
{
    
    if([self.icalLinkInfoList count] == index){
        icalLinkRecord.propertyid = [NSString stringWithFormat:@"%d", (index + 1)];
        [self.icalLinkInfoList addObject:icalLinkRecord];
    }else{
        
        [self.icalLinkInfoList replaceObjectAtIndex:index withObject:icalLinkRecord];
        
        [DataManager saveUpdatedRecordToPersistanceStore];
        //[self.icalLinkTableVIew reloadRowsAtIndexPaths:[self.icalLinkTableVIew indexPathsForVisibleRows]
                         //withRowAnimation:UITableViewRowAnimationNone];
    }
    
    [self.icalLinkTableVIew reloadData];
}


#pragma mark - Ical Cell Delegate

- (void)userPressedEditOnCell:(IcalLinkCell *)cell
{
    
    NSIndexPath *indexPath =  [self.icalLinkTableVIew indexPathForCell:cell];
    
    //Check the icallink's record should be in list before edit.
    if([self.icalLinkInfoList count] <= indexPath.row){
        NSLog(@"Warning: Total icallink record: %d and user want to edit record's number: %d", (NSInteger)[self.icalLinkInfoList count], (NSInteger) indexPath.row);
        return;
    }
    
   AddIcalPropertyVC *addIcalVC = [[AddIcalPropertyVC alloc] initWithNibName:kAddIcalNib bundle:nil];
    //Store icallink record to edit.
    addIcalVC.icalLinkRecord = [self.icalLinkInfoList objectAtIndex:indexPath.row];
    
    //Save index to update.
    addIcalVC.rowIndex = indexPath.row;
    
    addIcalVC.delegate = self;
    
    [self.navigationController pushViewController:addIcalVC animated:YES];
}



- (void)userPressedDeleteOnCell:(IcalLinkCell *)cell{
    
    NSIndexPath *indexPath =  [self.icalLinkTableVIew indexPathForCell:cell];
    
    //Delete form persistance store
    [DataManager deleteRecordFromPersistanceStore: [self.icalLinkInfoList objectAtIndex:indexPath.row]];
    
    //Remove record from list.
    [self.icalLinkInfoList removeObjectAtIndex:indexPath.row];
    
    //Delete row from tableview.
    [self.icalLinkTableVIew deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
