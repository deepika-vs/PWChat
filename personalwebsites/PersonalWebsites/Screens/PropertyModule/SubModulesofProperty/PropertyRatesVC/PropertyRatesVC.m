//
//  PropertyRatesVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 14/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "PropertyRatesVC.h"
#import "PropertyRatesCell.h"
#import "PropertyRatesEditVC.h"

#define kPropertyRatesCellKey       @"PropertyRatesCell"
#define kPropertyRatesEditVCKey     @"PropertyRatesEditVC"
#define kEditBtnName                @"pencil-edit-button.png"
#define kEmptyTitle                 kEmptyStr
#define kDeleteBtnName              @"delete-button.png"
#define kCellHeight                 215.0f
#define kPropertyRatesEditVCNib     @"PropertyRatesEditVC"


@interface PropertyRatesVC () <PropertyRatesCellDelegate, PropertyRatesEditVCDelegate>

@end


@implementation PropertyRatesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self removeRightNavItem];
    
    self.mTableView.estimatedRowHeight = 190;
    self.mTableView.rowHeight = UITableViewAutomaticDimension;
    
    UINib *nib = [UINib nibWithNibName:kPropertyRatesCellKey bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:kPropertyRatesCellKey];
    
    [self performSelector:@selector(createFloatingButton) withObject:nil afterDelay:0.01];
    
    self.ratesList = [[NSMutableArray alloc] init];
    
    //[self setData];TODO:: It will implement when data will load from api.
    
    // Do any additional setup after loading the view from its nib.
}


- (void) setData{
    //self.ratesList = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate <Methods>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 01;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //TODO: Tobe update on data.
    NSInteger nRates = [self.ratesList count];
    
    if(nRates > 0){
        self.addRateMsgView.hidden = YES;
    }else{
        self.addRateMsgView.hidden = NO;
    }
    return  nRates;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PropertyRatesCell *cell = [tableView dequeueReusableCellWithIdentifier:kPropertyRatesCellKey forIndexPath:indexPath];
    
    if(cell){
        
        cell.delegate = self;
        
        //Check the cell is already created & have its data.
        if([self.ratesList count] > indexPath.row){
            RateWrapper *rateRecord = [self.ratesList objectAtIndex:indexPath.row];
            [cell showRateRecordToCell: rateRecord];
        }
    }
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}

- (void)floatingButtonTapped
{
    [self navigateToAddRateScreen];
}



- (void)navigateToAddRateScreen
{
    PropertyRatesEditVC *rateEditVC = [[PropertyRatesEditVC alloc] initWithNibName:kPropertyRatesEditVCKey bundle:nil];
    
    rateEditVC.delegate = self;
    rateEditVC.rowIndex = [self.ratesList count];
    
    [self.navigationController pushViewController:rateEditVC animated:YES];
}


#pragma -Mark PropertyRatesEditVCDelegate <Method>

- (void)addOrUpdateRateWithRecord:(RateWrapper *) rateRecord atIndex: (NSInteger) index{
    if([self.ratesList count] == index){
        //Add new rate record.
        [self.ratesList addObject:rateRecord];
    }else{
        //update rate record.
        [self.ratesList replaceObjectAtIndex:index withObject:rateRecord];
    }
    
    [self.mTableView reloadData];
}



#pragma -Mark PropertyRatesCellDelegate <Methods>
- (void)userPressedEditBtnOnCell:(PropertyRatesCell *)cell{
    NSIndexPath *indexPath =  [self.mTableView indexPathForCell:cell];
    
    //Check the icallink's record should be in list before edit.
    if([self.ratesList count] <= indexPath.row){
        NSLog(@"Warning: Total icallink record: %d and user want to edit record's number: %d", (NSInteger)[self.ratesList count], (NSInteger) indexPath.row);
        return;
    }
    
    PropertyRatesEditVC *editRateVC = [[PropertyRatesEditVC alloc] initWithNibName:kPropertyRatesEditVCNib bundle:nil];
    
    //Store icallink record to edit.
    editRateVC.rateRecord = [self.ratesList objectAtIndex:indexPath.row];
    
    //Save index to update.
    editRateVC.rowIndex = indexPath.row;
    
    editRateVC.delegate = self;
    
    [self.navigationController pushViewController:editRateVC animated:YES];
}



- (void)userPressedDeleteBtnOnCell:(PropertyRatesCell *)cell{
    
    NSIndexPath *indexPath =  [self.mTableView indexPathForCell:cell];
    
    if([self.ratesList count] > indexPath.row){
        //Delete rate record from list.
        [self.ratesList removeObjectAtIndex:indexPath.row];
        
        //Delete row from tableview.
        [self.mTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
@end
