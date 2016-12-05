//
//  MenuSectionView.m
//  PersonalWebsites
//
//  Created by vectoscalar on 30/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "MenuSectionView.h"

@implementation MenuSectionView
@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)updateSectionMenuWithTitle:(NSString *)title andImageName:(NSString*)imgName
{
    if([imgName containsString:@"fa-"])
    self.sectionImage.image = [UIImage imageWithIcon:imgName backgroundColor:[UIColor clearColor] iconColor:[UIColor lightGrayColor] andSize:CGSizeMake(20, 20)];
    
    else
        self.sectionImage.image = [UIImage imageNamed:imgName];
    
    
    
    self.sectionTitle.text = title;
    
    [self addTapGestureToSection];
}


- (void)updateAccessorView
{
    self.accessoryIcon.font = kFontAwesomeFont(16);
    self.accessoryIcon.text = kFontAwesomeText(@"fa-angle-right");
}

- (void)updateAccessorViewWithDownArrow
{
    self.accessoryIcon.font = kFontAwesomeFont(16);
    self.accessoryIcon.text = kFontAwesomeText(@"fa-angle-down");
}


- (void)addTapGestureToSection
{
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnSection)];
    [self.sectionView addGestureRecognizer:tap];
}


- (void)userTappedOnSection
{
    [delegate userDidTapedOnSectionForTitle:self.sectionTitle.text onView:self];
}

@end
