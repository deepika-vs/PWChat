//
//  DatePickerView.h
//  PersonalWebsites
//
//  Created by VectoScalar on 18/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DatePickerViewDelegate <NSObject>

-(void) didUserPickedDate: (NSString *) date;

@end

@interface DatePickerView : UIView
{
    UIView *mainView;
    UIView *blurView;
    UIView *datePickerView;
    UIDatePicker *datePicker;
}

@property (assign,nonatomic) id <DatePickerViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;
- (void)configureUIWithFrame:(CGRect)frame;
- (void)addDatePicker;
- (void)addButtonsToDatePickerView;
- (void)addButton:(CGRect) frame addTitle:(NSString*) title titleFontSize: (CGFloat) fontSize addBtnAction:(SEL) buttonAction;
- (void)addTapGestureToMainView;
- (NSString *) getFormattedDate:(NSDate *) dateStr;

@end
