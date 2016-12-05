//
//  ModifyReviewsVC.h
//  PersonalWebsites
//
//  Created by vectoscalar on 17/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PWButton.h"
#import "PWTextField.h"
#import "ReviewWrapper.h"
#import "RichTextBaseController.h"

@protocol ModifyReviewsVCDelegate <NSObject>
//Delegate to add new Or edit the exiting review.

- (void)userAddNewOrEditReviewWithContents:(ReviewWrapper *) wrapper atRowIndex:(NSInteger) rowNum;

@end


@interface ModifyReviewsVC : BaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;

//Customer's name
@property (weak, nonatomic) IBOutlet UIView *customerNameView;

@property (weak, nonatomic) IBOutlet PWTextField *customerNameTextField;

//Customer image
@property (weak, nonatomic) IBOutlet UIView *userImageContainerView;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@property (weak, nonatomic) IBOutlet UILabel *imageActionlabel;

//Review heading
@property (weak, nonatomic) IBOutlet UIView *headingView;

@property (weak, nonatomic) IBOutlet PWTextField *headingTextField;

//Customer place
@property (weak, nonatomic) IBOutlet UIView *customerPlaceView;

@property (weak, nonatomic) IBOutlet PWTextField *customerPlaceTextField;

//List view for property's name.
@property (weak, nonatomic) IBOutlet UIView *listView;

@property (weak, nonatomic) IBOutlet UILabel *listItemLabel;

@property (weak, nonatomic) IBOutlet UILabel *downArrowIconlabel;

@property (strong, nonatomic) NSString *selectedPropertyName;

//Content's view.
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) NSString *reviewHtmlContent;

@property (weak, nonatomic) IBOutlet UIWebView *mWebView;


@property (weak, nonatomic) IBOutlet UIButton *editButton;

- (IBAction)userPressedEditButton:(UIButton *)sender;

//Review modify page type edit Or create new review.

@property (assign, nonatomic) id <ModifyReviewsVCDelegate> delegate;

//Index to add new & modify review.
@property (assign, nonatomic) NSInteger rowIndex;

@property (strong, nonatomic) ReviewWrapper *reviewWrapper;

//Required fields message labels.
@property (weak, nonatomic) IBOutlet UILabel *nameRequireLbl;

@property (weak, nonatomic) IBOutlet UILabel *headingRequireLbl;

@property (weak, nonatomic) IBOutlet UILabel *placeRequireLbl;

@property (weak, nonatomic) IBOutlet UILabel *prtNameRequireLbl;

@property (weak, nonatomic) IBOutlet UILabel *contentRequireLbl;


//Button to add review.
@property (weak, nonatomic) IBOutlet PWButton *submitButton;

- (IBAction)userPressedSubmitButton:(id)sender;

- (void) updateFieldsToEditReview;

@end
