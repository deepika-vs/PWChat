//
//  OnlineStatusCell.h
//  GoFro
//
//  Created by Rahul Mishra on 29/07/16.
//  Copyright © 2016 BonaVita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlineStatusCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (void)updateOnlineStatus:(NSString *)status;

@end
