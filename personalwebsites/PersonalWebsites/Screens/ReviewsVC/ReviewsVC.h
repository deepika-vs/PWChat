//
//  ReviewsVC.h
//  PersonalWebsites
//
//  Created by vectoscalar on 17/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ReviewsVC : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mReviewTV;

@property (weak, nonatomic) IBOutlet UIView *addMessageView;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (strong, nonatomic) NSMutableArray* customerReviewsList;

- (void) setVisibilityOfAddReviewMessage:(BOOL) isVisible;

@end
