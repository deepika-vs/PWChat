//
//  AdminHomeView.m
//  PersonalWebsites
//
//  Created by vectoscalar on 24/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "AdminHomeView.h"


#define kHomeViewTag        8765
#define kPropertyViewTag    8766
#define kICalViewTag        8767
#define kContactViewTag     8768
#define kReviewsViewTag     8769
#define kSocialLinkViewTag  8770


#define kFloatingButtonCornerRadius (kFloatingButtonSize/2) //Just Half of width

#define kPlusIcon   @"plusIcon"
#define kCrossIcon  @"crossIcon"

#define kFloatingButtonArray @[@"Chat",@"Mail us",@"Call us"]

@implementation AdminHomeView
@synthesize delegate;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)configureUI
{
    [self setUpUIForView:self.homeView andColor:[UIColor colorWithRed:0/255.0f green:157.0/255.0f blue:99.0/255.0f alpha:1.0]];
    [self setUpUIForView:self.propertyView andColor:[UIColor colorWithRed:3/255.0f green:108.0/255.0f blue:227.0/255.0f alpha:1.0]];
    [self setUpUIForView:self.iCalView andColor:[UIColor colorWithRed:221/255.0f green:62.0/255.0f blue:50.0/255.0f alpha:1.0]];
    
    [self addTapGesture];
    
    //Add Floating Button
    [self addFloatingButton];
    
    self.homeImageView.image = [UIImage imageWithIcon:kHomeFA backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] andSize:CGSizeMake(26, 26)];
    self.propertyImageView.image = [UIImage imageWithIcon:kBuildingFA backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] andSize:CGSizeMake(26, 26)];
    self.icalImageView.image = [UIImage imageWithIcon:kICalFA backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] andSize:CGSizeMake(26, 26)];
    self.reviewImageView.image = [UIImage imageWithIcon:kReviewFA backgroundColor:[UIColor clearColor] iconColor:[UIColor colorWithRed:219/255.0f green:219.0/255.0f blue:219.0/255.0f alpha:1.0] andSize:CGSizeMake(26, 26)];
    
}


- (void)addFloatingButton
{
    
    CGRect floatFrame = kFloatingBtnFrame;
    
    
    VCFloatingActionButton * addButton = [[VCFloatingActionButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:kPlusIcon] andPressedImage:[UIImage imageNamed:kCrossIcon] withScrollview:nil];
    
    addButton.backgroundColor = [UIColor clearColor];
    
    //    NSDictionary *optionsDictionary = @{@"fb-icon":@"Facebook",@"twitter-icon":@"Twitter",@"google-icon":@"Google Plus",@"linkedin-icon":@"Linked in"};
    //    addButton.menuItemSet = optionsDictionary;
    addButton.labelArray = kFloatingButtonArray;
    
    addButton.hideWhileScrolling = YES;
    addButton.delegate = self;
    [self addSubview:addButton];
    //  [[[UIApplication sharedApplication] keyWindow] addSubview:addButton];
}



- (IBAction)userDidPressedFloatingButton:(id)sender {
}



- (void)setUpUIForView:(UIView*)view andColor:(UIColor *)color
{
    view.layer.cornerRadius = self.homeView.frame.size.width/2;
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = 2.0f;
    
    if(kScreenWidth > 320.0)
    {
        self.homeViewTopConstraint.constant = 8;
        self.propertyViewTopConstratin.constant = 8;
        self.iCalTopConstratin.constant = 8;
    }
    else
    {
        self.homeViewTopConstraint.constant = -5;
        self.propertyViewTopConstratin.constant = -5;
        self.iCalTopConstratin.constant = -5;
    }
}


- (void)addTapGesture
{
    
    //Add to Home
    UITapGestureRecognizer *homeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userSelectedPage:)];
    [self.homeView addGestureRecognizer:homeGesture];
    
    //Add to Property
    UITapGestureRecognizer *propertyGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userSelectedPage:)];
    [self.propertyView addGestureRecognizer:propertyGesture];
    
    
    //Add to Social Link
    
    //Add to Ical
    UITapGestureRecognizer *icalGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userSelectedPage:)];
    [self.iCalView addGestureRecognizer:icalGesture];
    
    //Add to Contact
    UITapGestureRecognizer *contactGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userSelectedPage:)];
    [self.contactView addGestureRecognizer:contactGesture];
    
    //add to Review
    UITapGestureRecognizer *reviewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userSelectedPage:)];
    [self.reviewView addGestureRecognizer:reviewGesture];
    
    //Add to Social Link
    UITapGestureRecognizer *socialGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userSelectedPage:)];
    [self.socialView addGestureRecognizer:socialGesture];
    
}


- (void)userSelectedPage:(id)sender
{
    UITapGestureRecognizer *tap  = (UITapGestureRecognizer*)sender;
    
    int tag = (int)tap.view.tag;
    
    switch (tag) {
        case kHomeViewTag:
            [delegate userDidSelectPagesInDashboardView:HomePage];
            break;
            
        case kPropertyViewTag:
            [delegate userDidSelectPagesInDashboardView:PropertyPage];
            break;
            
        case kICalViewTag:
            [delegate userDidSelectPagesInDashboardView:IcalPage];
            break;
            
            
        case kContactViewTag:
            [delegate userDidSelectPagesInDashboardView:ContactPage];
            break;
            
            
        case kReviewsViewTag:
            [delegate userDidSelectPagesInDashboardView:ReviewPage];
            break;
            
            
        case kSocialLinkViewTag:
            [delegate userDidSelectPagesInDashboardView:SocialLinkPage];
            break;
            
            
        default:
            break;
    }
}

#pragma mark - Floating menu delegate
- (void)didSelectMenuOptionAtIndex:(NSInteger)row
{
    [delegate userDidPressedFloatingButtonWithIndex:(int)row];
}

@end
