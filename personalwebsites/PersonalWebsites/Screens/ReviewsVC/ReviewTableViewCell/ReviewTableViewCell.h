//
//  ReviewTableViewCell.h
//  PersonalWebsites
//
//  Created by VectoScalar on 19/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ReviewWrapper.h"

@class ReviewTableViewCell;

@protocol ReviewTableViewCellDelegate <NSObject>

- (void)userPressedEditReviewOnCell:(ReviewTableViewCell*)cell;

- (void)userPressedDeleteReviewOnCell:(ReviewTableViewCell*)cell;

@end


@interface ReviewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *contentsView;

//Customer review info outlets.
@property (weak, nonatomic) IBOutlet UIImageView *usrImgView;

@property (weak, nonatomic) IBOutlet UILabel *uNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;

@property (weak, nonatomic) IBOutlet UILabel *reviewHeadingLbl;

@property (weak, nonatomic) IBOutlet UILabel *propertyNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *contentsLbl;

//@property (weak, nonatomic) IBOutlet UIView *ratingView;

//@property (weak, nonatomic) IBOutlet UIView *playView;

@property (assign,nonatomic) id <ReviewTableViewCellDelegate> delegate;

- (void) setDataToCellFields:(ReviewWrapper *) wrapper;

//Control button's outlets & actions for edit Or delete review.
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

- (IBAction)userPressedDeleteBtn:(UIButton *)sender;

- (IBAction)userPressedEditBtn:(UIButton *)sender;

@end
