//
//  floatTableViewCell.m
//  floatingButtonTrial
//
//  Created by Giridhar on 26/03/15.
//  Copyright (c) 2015 Giridhar. All rights reserved.
//

#import "floatTableViewCell.h"

@implementation floatTableViewCell
@synthesize imgView, title,overlay;

- (void)awakeFromNib
{
    // Initialization code
    [super awakeFromNib];

    
    overlay = [UIView new];
    overlay.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
    
    [title addSubview:overlay];
    self.imageHolder.layer.cornerRadius = 50/2;
    self.imageHolder.layer.masksToBounds = YES;
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.transform = CGAffineTransformMakeRotation(-M_PI);
    _wrapperView.layer.cornerRadius  = 5.0f;
    
}


-(void)setTitle:(NSString*)txt andImage:(UIImage*)img
{
//    self.title.text = txt;
//    
//    CGFloat width = ceil([self.title.text sizeWithAttributes:@{NSFontAttributeName: self.title.font}].width);
//    
//    CGFloat height = ceil([self.title.text sizeWithAttributes:@{NSFontAttributeName: self.title.font}].height);
//    
//    overlay.frame = CGRectMake(CGRectGetMaxX(self.title.frame), CGRectGetMaxY(self.title.frame), width, height);
//    
//    
//    
//    self.imgView.image = img;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
