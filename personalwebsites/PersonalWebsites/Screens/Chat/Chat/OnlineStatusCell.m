//
//  OnlineStatusCell.m
//  GoFro
//
//  Created by Rahul Mishra on 29/07/16.
//  Copyright © 2016 BonaVita. All rights reserved.
//

#import "OnlineStatusCell.h"

@implementation OnlineStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateOnlineStatus:(NSString *)status
{
    self.statusLabel.text = status;
}

@end
