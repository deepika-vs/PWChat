//
//  ReviewsVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 17/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "ReviewsVC.h"
#import "ModifyReviewsVC.h"
#import "ReviewTableViewCell.h"

#define kSceenTitle         @"Reviews"
#define kModifyReviewsNib   @"ModifyReviewsVC"
#define kReviewTVCellKey    @"ReviewTableViewCell"

#define kNavigationButtonFont 22

@interface ReviewsVC () <ReviewTableViewCellDelegate, ModifyReviewsVCDelegate>

@end


@implementation ReviewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.needToShowBackButton = YES;
    [self createNavigationBarLeftItems];
    self.navigationItem.title = kSceenTitle;
    
    //Register review cell nib to tableview.
    UINib *nib = [UINib nibWithNibName:kReviewTVCellKey bundle:nil];
    [self.mReviewTV registerNib:nib forCellReuseIdentifier:kReviewTVCellKey];
    
    
    self.mReviewTV.estimatedRowHeight = 80;
    self.mReviewTV.rowHeight = UITableViewAutomaticDimension;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //Prepare data for tableview
    [self setDataToReview];
    
    [self performSelector:@selector(createFloatingButton) withObject:nil afterDelay:0.01];
    
    // Do any additional setup after loading the view from its nib.
}


- (void) setDataToReview{
    //TODO: Add data in actual case from api.
    if(self.customerReviewsList == nil){
        self.customerReviewsList = [[NSMutableArray alloc] init];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Add new reivew on click plus icon.
- (void)floatingButtonTapped
{
    ModifyReviewsVC *modifyReviewVC = [[ModifyReviewsVC alloc] initWithNibName:kModifyReviewsNib bundle:nil];
    
    //Set delegate to review.
    modifyReviewVC.delegate = self;
    
    //Add one more customer's review in tableview at rowIndex.
    modifyReviewVC.rowIndex = [self.customerReviewsList count];
    
    //No need to edit.
    modifyReviewVC.reviewWrapper = nil;
    
    [self.navigationController pushViewController:modifyReviewVC animated:YES];
}



#pragma mark - Revire TableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //TODO: Tobe update with api's data.
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //TODO: Tobe update with api's data.
    NSInteger nRows = [self.customerReviewsList count];
    
    //Hide and show

    if(nRows > 0){
        [self setVisibilityOfAddReviewMessage: YES];
    }else{
        [self setVisibilityOfAddReviewMessage: NO];
    }
    
    return nRows;
}


- (void) setVisibilityOfAddReviewMessage:(BOOL) isVisible{
    self.addMessageView.hidden = isVisible;
    self.messageLabel.hidden = isVisible;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReviewTVCellKey forIndexPath:indexPath];
    
    if(cell){
        //set cell delegate.
        cell.delegate = self;
        
        //Check cell's data in list.
        if([self.customerReviewsList count] > indexPath.row){
            
            ReviewWrapper *reviewRecord = [self.customerReviewsList objectAtIndex:indexPath.row];
            
            //Display review record to tableview cell.
            [cell setDataToCellFields: reviewRecord];
        }
    }
    
    return cell;
}



#pragma mark- AddNew Or Exit Review Delegate

- (void) userAddNewOrEditReviewWithContents:(ReviewWrapper *)wrapper atRowIndex:(NSInteger)rowNum{
    
    [wrapper.reviewDate setValue:[NSString stringWithFormat:@"%@", [NSDate date]] forKey: kIcalAddedDateKey];
    
    //Check if user want to add a new review.
    if([self.customerReviewsList count] == rowNum){
        [self.customerReviewsList addObject:wrapper];
        
    }else{
        //If user already have review record for the index then update it.
        [self.customerReviewsList replaceObjectAtIndex:rowNum withObject:wrapper];
    }
    
    [self.mReviewTV reloadData];
}


#pragma mark - ReviewTableViewCell deleggate.

- (void) userPressedDeleteReviewOnCell:(ReviewTableViewCell *)cell{
    //Get indexPath for the cell user want to delete.
    NSIndexPath *indexPath =  [self.mReviewTV indexPathForCell:cell];
    
    //Remove review record from list for the index.
    [self.customerReviewsList removeObjectAtIndex:indexPath.row];
    
    //Delete row from tableview.
    [self.mReviewTV deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}



- (void) userPressedEditReviewOnCell:(ReviewTableViewCell *)cell{
    
    NSIndexPath *indexPath =  [self.mReviewTV indexPathForCell:cell];
    
    //Check the review's record should be in list before edit.
    if([self.customerReviewsList count] <= indexPath.row){
        NSLog(@"Warning: Total review record: %d and user want to edit record's number: %d", [self.customerReviewsList count], indexPath.row);
        
        return;
    }
    
    ModifyReviewsVC *modifyReviewVC = [[ModifyReviewsVC alloc] initWithNibName:kModifyReviewsNib bundle:nil];
    //Store review record to edit.
    modifyReviewVC.reviewWrapper = [self.customerReviewsList objectAtIndex:indexPath.row];
    
    //Save index to update.
    modifyReviewVC.rowIndex = indexPath.row;
    
    modifyReviewVC.delegate = self;
    
    //Goto update view.
    [self.navigationController pushViewController:modifyReviewVC animated:YES];
    
}
@end
