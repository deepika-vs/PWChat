//
//  DatePickerView.m
//  PersonalWebsites
//
//  Created by VectoScalar on 18/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "DatePickerView.h"

#define kOKBtnTitle @"OK"
#define kCancelBtnTitle @"Cancel"
#define kDateFormatStr @"dd-MMM-yyyy"
#define kSelectDateMessage @"Select Date"

#define kDatePickerViewHeight 296.0f
#define kDatePickerHeight 216.0f
#define kXpading 10

@implementation DatePickerView
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self)
    {
        [self configureUIWithFrame:frame];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return  self;
}


-(void)configureUIWithFrame:(CGRect)frame {
    
    mainView = [[UIView alloc] initWithFrame:frame];
    //Add main view to center of the superview.
    mainView.center = self.center;
    [self addSubview:mainView];
    
    mainView.backgroundColor = [UIColor clearColor];
    //Add blurview to handle tap gesture.
    blurView = [[UIView alloc] initWithFrame:frame];
    
    [mainView addSubview:blurView];
    [UIView animateWithDuration:0.2 animations:^{
        blurView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
    }];
    
    //Add datepickerview.
    CGFloat xPos = kXpading;
    CGFloat yPos = (frame.size.height - kDatePickerViewHeight) / 2;
    
    datePickerView = [[UIView alloc] initWithFrame:CGRectMake(xPos,
                                                              yPos,
                                                              kScreenWidth-2*kXpading,
                                                              kDatePickerViewHeight)];
    
    datePickerView.backgroundColor = [UIColor whiteColor];
    
    datePickerView.layer.cornerRadius = 4.0f;
    [mainView addSubview:datePickerView];
    datePickerView.clipsToBounds = YES;
    
    //Add datePicker.
    [self addDatePicker];
    
    //Add tapgesture
    [self addTapGestureToMainView];
}


- (void)addDatePicker {
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0,
                                                                40,
                                                                datePickerView.frame.size.width,
                                                                kDatePickerHeight)];
    
    if(datePicker) {
        [datePicker setDate:[NSDate date]];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.backgroundColor = [UIColor whiteColor];
       
        //Add datepicker to its view.
        [datePickerView addSubview:datePicker];
        
        //Add buttons to save/cancel datepicker result.
        [self addButtonsToDatePickerView];
        
        //Add label to top of the view.
        UILabel *messageLbl = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                        0.0,
                                                                        datePickerView.frame.size.width,
                                                                        40.0)];
        [messageLbl setTextAlignment:NSTextAlignmentCenter];
        [messageLbl setBackgroundColor:kNavColor];
        [messageLbl setText:kSelectDateMessage];
        [messageLbl setFont:[UIFont fontWithName:kFontNameWithBold size:14]];
        [messageLbl setTextColor: [UIColor whiteColor]];
        
        [datePickerView addSubview:messageLbl];
    }
}



-(void)addButtonsToDatePickerView {
    
    CGRect frame = datePickerView.bounds;
    CGFloat fontSize = 14.0f;
    CGFloat buttonWidth = (frame.size.width - 3 * kXpading) / 2;
    
    //Add cancel button for datepicker.
    frame.origin.x = kXpading;
    frame.origin.y = frame.size.height - 50;
    frame.size.width = buttonWidth;
    frame.size.height = 40.0;
    
    SEL cancelBtnSel = @selector(cancelBtnAction:);
    [self addButton:frame addTitle:kCancelBtnTitle titleFontSize: fontSize addBtnAction: cancelBtnSel];
    
    //Add ok button for datepicker.
    frame.origin.x +=(buttonWidth + kXpading);
    
    SEL okBtnSel = @selector(okBtnAction:);
    [self addButton:frame addTitle:kOKBtnTitle titleFontSize: fontSize addBtnAction: okBtnSel];
    

}


- (void)addButton:(CGRect) frame addTitle:(NSString*) title titleFontSize: (CGFloat) fontSize addBtnAction:(SEL) buttonAction {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    [button addTarget:self action:buttonAction forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button.titleLabel setFont:[UIFont fontWithName:kFontNameWithBold size:fontSize]];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button setBackgroundColor:kNavColor];
    
    [datePickerView addSubview:button];
}


- (void)addTapGestureToMainView
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOutside)];
    [blurView addGestureRecognizer:gesture];
}


- (void)userTappedOutside
{
    [self removeFromSuperview];
}


-(void) okBtnAction:(UIButton *) sender{
    //Save picked date & display.
    NSString *dateInFormat = [self getFormattedDate: datePicker.date];
    [delegate didUserPickedDate:dateInFormat];
    [self removeFromSuperview];
}


- (NSString *) getFormattedDate:(NSDate *) dateStr{
    //Format date for view.
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = kDateFormatStr;
    
    return [dateFormatter stringFromDate:dateStr];
}


-(void) cancelBtnAction:(UIButton *) sender{
    //No need toupdate date on cancel.
    [self removeFromSuperview];
}

@end
