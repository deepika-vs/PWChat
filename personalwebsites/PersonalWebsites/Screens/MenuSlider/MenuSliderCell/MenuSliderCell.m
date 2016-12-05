//
//  MenuSliderCell.m
//  SportInfo
//
//  Created by vectoscalar on 24/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "MenuSliderCell.h"

@implementation MenuSliderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateMenuWithTitle:(NSString *)title withImageName:(NSString *)imgName
{
    self.menuTitleLabel.text = title;
    [self.menuTitleLabel setFont:[UIFont fontWithName:kFontName size:14]];
    if([imgName containsString:@"fa-"])
    self.menuIcon.image  = [UIImage imageWithIcon:imgName backgroundColor:[UIColor clearColor] iconColor:[UIColor lightGrayColor] andSize:CGSizeMake(19, 19)];
    else
        self.menuIcon.image = [UIImage imageNamed:imgName];
}

@end
