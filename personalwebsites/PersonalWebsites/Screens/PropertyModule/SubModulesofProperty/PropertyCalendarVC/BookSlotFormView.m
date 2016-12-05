//
//  BookSlotFormView.m
//  PersonalWebsites
//
//  Created by VectoScalar on 15/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "BookSlotFormView.h"

#define kXpadding         10.0
#define kFormViewHeight   360.0
#define kYMargin          15
#define kHeaderTextHeight 21.0
#define kFormHeaderHeight 50.0

#define kNameText         @"Name"
#define kEmailText        @"Email"

#define kDateFormatStr    @"dd/MM/yyyy"

@implementation BookSlotFormView

- (id)initWithTitle:(NSString *)headerTitle{
    self = [super init];
    
    if(self){
        [self configureUIViewWithTitle: headerTitle];
    }
    
    return self;
}


- (void)configureUIViewWithTitle: (NSString *) title{
    
    CGRect screenFrame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    //self.frame = screenFrame;
    
    mainView = [[UIView alloc] initWithFrame:screenFrame];
    
    //[self addSubview:mainView];
    [[[UIApplication sharedApplication]keyWindow] addSubview:mainView];
    
    //Add blurview to handle tap gesture.
    UIView *blurView = [[UIView alloc] initWithFrame:screenFrame];
    
    
    [mainView addSubview:blurView];
    
    [UIView animateWithDuration:0.2 animations:^{
        blurView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
    }];
    
    //Add bookslotformview.
    CGFloat xPos = kXpadding * 2;
    CGFloat yPos = (screenFrame.size.height - kFormViewHeight) / 2;
    
    UIView *bookSlotFromView = [[UIView alloc] initWithFrame:CGRectMake(xPos,
                                                                        yPos,
                                                                        (kScreenWidth - 2 * xPos),
                                                                        kFormViewHeight)];
    
    bookSlotFromView.layer.cornerRadius = 3.0f;
    bookSlotFromView.clipsToBounds = YES;
    
    [bookSlotFromView setBackgroundColor:[UIColor whiteColor]];
     
    //Add formview to mainview.
    [mainView addSubview:bookSlotFromView];
    
    //Add attributes on FromView.
    [self addAttributesFieldsOnFormView:bookSlotFromView with:title];
    
    //Add gesture to close on tap outside.
    [self addTapGestureToMainView: blurView];
    
}


//Add attributes on formview.
- (void)addAttributesFieldsOnFormView:(UIView *)formView with:(NSString *)title{
    CGRect frame = formView.bounds;
    
    //Add form header with title.
    frame.size.height = kFormHeaderHeight;
    [self addHeaderOnBookFromView: formView withFrame: frame andTitle: title];
    
    //Add name input field to form.
    frame.origin.x = kXpadding;
    frame.size.width -= (2 * kXpadding);
    frame.origin.y += (kFormHeaderHeight + kYMargin);
    
    self.nameTextField = [[UITextField alloc] init];
    [self addTextField:self.nameTextField OnView:formView  withFrame:frame andText:kNameText];
    
    //Add user email field to form.
    frame.origin.y += (kHeaderTextHeight + 45 + kYMargin);
    self.emailTextField = [[UITextField alloc] init];
    [self addTextField:self.emailTextField OnView:formView  withFrame:frame andText:kEmailText];
    
    //Add Date view labels and buttons.
    frame.origin.y += (kHeaderTextHeight + 45 + kYMargin);
    [self addDatesButtonsOnView:formView withFrame:frame];
    
}


//Add header on view.
- (void) addHeaderOnBookFromView: (UIView *) view withFrame: (CGRect) headerFrame andTitle:(NSString *) title{
    UILabel *headerLbl = [[UILabel alloc] initWithFrame:headerFrame];
    
    headerLbl.text = title;
    
    headerLbl.textAlignment = NSTextAlignmentCenter;
    
    [headerLbl setFont:[UIFont fontWithName:kFontNameWithBold size:15]];
    
    [headerLbl setTextColor:[UIColor whiteColor]];
    
    [headerLbl setBackgroundColor:kNavColor];
    
    [view addSubview:headerLbl];
}



- (void)addTextField:(UITextField *) textField OnView:(UIView *) formView  withFrame : (CGRect) frame andText:(NSString *) title{
    frame.size.height = kHeaderTextHeight;
    
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:frame];
    nameLbl.text = title;
    
    nameLbl.textAlignment = NSTextAlignmentLeft;
    [nameLbl setFont:[UIFont fontWithName:kFontName size:14]];
    [nameLbl setAlpha:0.6];
    
    [formView addSubview:nameLbl];
    
    //Set frame to name textfield.
    frame.origin.y += kHeaderTextHeight;
    frame.size.height = 45;
    
    textField.frame = frame;
    [textField setPlaceholder:title];
    
    textField.backgroundColor = kInputFieldBGColor;
    [textField setFont:[UIFont fontWithName:kFontName size:14]];
    
    //Add let padding to text field
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    [textField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    
    [formView addSubview:textField];
}


- (void) textFieldDidChange:(UITextField *) textField{
    NSLog(@"Tes: %@", textField.text);
}



- (void)addDatesButtonsOnView:(UIView *) formView withFrame: (CGRect) frame{
    
    CGFloat buttonwhidth = (frame.size.width - kXpadding) / 2;
    
    frame.size.width = buttonwhidth;
    
    [self addDatesOnView: formView withFrame: frame];
    
    //Add button on form view.
    frame.origin.y += (kHeaderTextHeight + 45 + kYMargin);
    frame.size.height = 40;
    //Add cancel button on form.
    NSString *title = @"Cancel";
    SEL cancelBtnMethod = @selector(didCancelButtonPressed:);
    
    [self addButtonOnFromView:formView withFrame: frame andTitle: title andMethod: cancelBtnMethod];
    
    //Add Book slot button.
    frame.origin.x += (buttonwhidth + kXpadding);
    
    title = @"Book";
    
    SEL bookBtnMethod = @selector(didBookSlotButtonPressed:);
    
    [self addButtonOnFromView:formView withFrame: frame andTitle: title andMethod: bookBtnMethod];

}


//Add start & end date view on formview.
- (void)addDatesOnView: (UIView *)formView withFrame:(CGRect) frame{
    //Add start date header label.
    
    NSString *startDateLblText = @"First Date";
    [formView addSubview:[self addLabel:frame :startDateLblText]];
    
    //Add start date header label.
    frame.origin.x += (frame.size.width + kXpadding);
    NSString *endDateLblText = @"Last Date";
    [formView addSubview:[self addLabel:frame :endDateLblText]];
    
    //Add start date display label.
    frame.origin.x = kXpadding;
    frame.origin.y += kHeaderTextHeight;
    
    self.startDateLbl = [[UILabel alloc] init];
    [self addDateLabel:self.startDateLbl onView:formView withFrame: frame];
    
    
    //Add end date display label.
    frame.origin.x += (frame.size.width + kXpadding);
    self.endDateLbl = [[UILabel alloc] init];
    [self addDateLabel:self.endDateLbl onView:formView withFrame: frame];
}



-(UILabel *) addLabel:(CGRect) frame : (NSString *) text{
    
    frame.size.height = kHeaderTextHeight;
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.text = text;
    
    label.textAlignment = NSTextAlignmentLeft;
    
    [label setFont:[UIFont fontWithName:kFontName size:14]];
    
    [label setAlpha:0.6];

    return label;
}



-(void) addDateLabel:(UILabel *) label onView:(UIView *) formView withFrame: (CGRect) frame{
    
    frame.size.height = 40;
    
    label.frame = frame;
    
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont fontWithName:kFontName size:14]];
    [label setAlpha:0.8];
    
    [label setBackgroundColor:kInputFieldBGColor];
    
    //[label setText:@"TEST"];
    [formView addSubview:label];
}



- (void)addButtonOnFromView:(UIView *)formView withFrame: (CGRect)frame andTitle:(NSString *) title andMethod:(SEL) methodSelector{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setFrame:frame];
    
    [button addTarget:self
               action:methodSelector
           forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setBackgroundColor:kNavColor];
    
    [button.titleLabel setFont:[UIFont fontWithName:kFontNameWithBold size:14]];
   
    [button setTintColor:[UIColor whiteColor]];
    
    [formView addSubview:button];
}



- (void) didCancelButtonPressed:(UIButton *) sender{
    [self.delegate userPressedCancelSlot];
    
    //Remove from view.
    [self userTappedOutside];
}



- (void) didBookSlotButtonPressed:(UIButton *) sender{
    
    if([self isAllInputValid]){    
        self.slot.name = self.nameTextField.text;
        self.slot.email = self.emailTextField.text;
        
        [self.delegate userPressedToBookSlot:self.slot];
        //Remove from view.
        [self userTappedOutside];
    }
}



- (BOOL)isAllInputValid{

    BOOL isValidInput = YES;
  //TODO::REmove comment for actual case.
    if([Utility isEmptyOrNilForString: self.nameTextField.text]){
        isValidInput = NO;
    }else if(![Utility isVaildEmail: self.emailTextField.text]){
        isValidInput = NO;
    }
    
    if(isValidInput == NO){
        [Utility showAlerWithMgs:@"Please provide valid input to all fields"];
    }
    
    return isValidInput;
}



- (void)addTapGestureToMainView:(UIView *) view{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOutside)];
    [view addGestureRecognizer:gesture];
}


- (void)userTappedOutside
{
    [mainView removeFromSuperview];
}


-(NSString *) convertDateToString:(NSDate *) date{
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:kDateFormatStr];
    NSString *dateStr = [df stringFromDate:date];
    
    return dateStr;
}


- (void) displayBookingDate{
    self.startDateLbl.text = [self convertDateToString:self.slot.firstDate];
    self.endDateLbl.text = [self convertDateToString:self.slot.lastDate];
}


//carete sloat before booked.

- (void) createSlotWithDate: (NSDate *) firstDate endDate:(NSDate *) endDate{
    
    self.slot = [[CalendarBookedSlot alloc] initWithName:self.nameTextField.text andEmail:self.emailTextField.text];
    
    self.slot.firstDate = firstDate;
    self.slot.lastDate = endDate;
    
    //Display dates.
    [self displayBookingDate];
}

@end
