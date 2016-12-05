//
//  DropDownCell.m
//  PersonalWebsites
//
//  Created by vectoscalar on 17/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "DropDownCell.h"

@implementation DropDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.menuItemLabel.text = @"";
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)updateMenuItem:(NSString *)menuItem
{
    self.menuItemLabel.text = menuItem;
    [self.menuItemLabel setFont:[UIFont fontWithName:kFontName size:14.0]];
}

@end
