//
//  AddAmenituView.m
//  PersonalWebsites
//
//  Created by vectoscalar on 26/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "AddAmenituView.h"

#define kXPadding               10.0
#define kYPadding               6.0
#define kGap                    10.0
#define kBottomMargin           8.0
#define kViewAmenityMargin      24.0

#define kFontStyle              @"Helvetica" //Arial
#define kFontSize               14.0f
#define kLabelHeight            30.0f
#define kDelAmenityBtnSize      35.0f

#define kCrossBtn               @"cross-light-gray.png"
#define kDelCategoryMsg         @"Are you sure, you want to delete the category?"
#define kDelAmenityMsg          @"Are you sure, you want to delete the amenity"?
#define kPlaceHolderText        @"Enter new amenity data"
#define kAddAmenityBtnTitle     @"Add Amenity"
#define kAddNewAmenityHeadText  @"Add new amenity"
#define kAmenityDataMgs         @"Please enter amenity data"

#define kDelAmenityBtnBaseTag   87987
#define kDelCategoryBtnTag      20511

#define kXpadingAmenityView     40.0f
#define kAddAmenityViewHeight   180.0f
#define kSubmitBtnColor         kNavColor

@implementation AddAmenituView
@synthesize delegate;

- (id)initWithTitle:(NSString *)title andPlaceholder:(NSString *)placeholderTitle andBtnTitle :(NSString *)buttonTitle
{
    self  = [super init];
    
    if(self)
    {
        headingTitle = title;
        placeholder = placeholderTitle;
        submitButtonTitle = buttonTitle;
        
        
        [self configureUIViewWithTitle:title andPlaceholder:placeholderTitle :buttonTitle];
    }
    
    return self;
}



-(void) configureUIViewWithTitle:(NSString *)title andPlaceholder:(NSString *)andBtnTitle :(NSString *)buttonTitle{
    CGRect frame = CGRectMake(0.0, 0.0, kScreenWidth, kScreenHeight);
    
    mainView = [[UIView alloc] init];
    mainView.frame = frame;
    [[[UIApplication sharedApplication]keyWindow] addSubview:mainView];
    
    mainView.backgroundColor = [UIColor clearColor];
    //Add blurview to handle tap gesture.
    UIView *blurView = [[UIView alloc] initWithFrame:frame];
    
    [mainView addSubview:blurView];
    [UIView animateWithDuration:0.2 animations:^{
        blurView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
    }];
    
    //Add datepickerview.
    CGFloat xPos = kXpadingAmenityView;
    CGFloat yPos = (frame.size.height - kAddAmenityViewHeight) / 2;
    
    UIView *addAmenityView = [[UIView alloc] initWithFrame:CGRectMake(xPos,
                                                                      yPos,
                                                                      (kScreenWidth - 2*kXpadingAmenityView),
                                                                      kAddAmenityViewHeight)];
    
    addAmenityView.layer.cornerRadius = 3.0f;
    addAmenityView.clipsToBounds = YES;
    //Add amenityview to mainview.
    [mainView addSubview:addAmenityView];
    
    addAmenityView.backgroundColor = [UIColor whiteColor];
    //Add datePicker.
    [Utility addShadowToView:addAmenityView];
    [self configureUIOnView:addAmenityView];
    //Add gesture to close on tap outside.
    [self addTapGestureToMainView: blurView];
}




- (void) configureUIOnView: (UIView *) view{
    CGRect frame = view.bounds;
    CGFloat yPos = frame.size.height - 40;
    CGFloat btnWidth = frame.size.width;

    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn addTarget:self
                  action:@selector(onSubmitBtnClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    
    [submitBtn.titleLabel setFont:[UIFont fontWithName:kFontNameWithBold size:15]];
    
    [submitBtn setTitle:submitButtonTitle forState:UIControlStateNormal];
    
    submitBtn.frame = CGRectMake(0, yPos, btnWidth, 40.0);
    [submitBtn setBackgroundColor:kSubmitBtnColor];
    
    submitBtn.clipsToBounds = YES;
    
    submitBtn.titleLabel.font = [UIFont fontWithName:kFontNameWithBold size: kFontSize];
    [view addSubview:submitBtn];

    //addTextfield
    CGFloat xPos = 10;
    textField = [[UITextField alloc] initWithFrame:CGRectMake(xPos,
                                                              20,
                                                              btnWidth - 2 * xPos,
                                                              40)];
    
    UIColor *placeHolderColor = [UIColor lightGrayColor];
    textField.backgroundColor = [UIColor colorWithWhite:0.90 alpha:0.2];
    textField.textAlignment = NSTextAlignmentCenter;
    
    [Utility changePlaceholderTextColor:textField withColor:placeHolderColor containsPlaceholderText:placeholder];
    
    textField.font = [UIFont fontWithName:kFontName size:kFontSize+2];
    textField.adjustsFontSizeToFitWidth = YES;
    
    //Add left padding.
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, textField.frame.size.height)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.spellCheckingType = UITextSpellCheckingTypeNo;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [view addSubview:textField];
    
    //Add bottom border view.
    CGRect borderViewFrame = CGRectMake(kXPadding,
                                        textField.frame.origin.y + textField.frame.size.height,
                                        textField.frame.size.width,
                                        1.0);
    
    UIView *borderView = [[UIView alloc] initWithFrame:borderViewFrame];
    [borderView setBackgroundColor:kNavColor];
    [view addSubview:borderView];
    
    //Message label.
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(xPos,
                                                             textField.frame.size.height+40,
                                                             btnWidth - 2 * xPos,
                                                             40)];
    lbl.text = headingTitle;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor darkGrayColor];

    lbl.font = [UIFont fontWithName:kFontName size:kFontSize+1];
    lbl.lineBreakMode = NSLineBreakByWordWrapping;
    lbl.numberOfLines = 2;
    
    [view addSubview:lbl];

}



- (void)addTapGestureToMainView:(UIView *) view
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOutside)];
    [view addGestureRecognizer:gesture];
}



- (void)userTappedOutside
{
    [mainView removeFromSuperview];
}



-(void) onSubmitBtnClicked: (UIButton *) sender{
    //Add logic to submit btn.
    NSString *text = [Utility trimWhiteSpacesAndNewLinesFromString:textField.text];
    
    if([text length] >0){
        [delegate didUserAddedAmenity:text onView:self];
          [mainView removeFromSuperview];
    }else{
        [Utility showAlerWithMgs:kAmenityDataMgs];
    }
    
    textField.text = kEmptyStr;
}


@end
