//
//  BookSlotFormView.h
//  PersonalWebsites
//
//  Created by VectoScalar on 15/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarBookedSlot.h"

@class BookSlotFormView;

@protocol BookSlotFormViewDelegate <NSObject>

- (void)userPressedToBookSlot:(CalendarBookedSlot *) Bookslot;
- (void)userPressedCancelSlot;

@end


@interface BookSlotFormView : UIView
{
    UIView *mainView;
}

@property (assign, nonatomic) id <BookSlotFormViewDelegate> delegate;

@property (strong, nonatomic) UITextField *nameTextField, *emailTextField;

@property (strong, nonatomic) UILabel *startDateLbl, *endDateLbl;

@property (strong, nonatomic) CalendarBookedSlot *slot;

- (void)configureUIViewWithTitle: (NSString *) title;

- (id)initWithTitle:(NSString *)headerTitle;

- (void)addAttributesFieldsOnFormView:(UIView *)formView with:(NSString *)title;

- (void) addHeaderOnBookFromView: (UIView *) view withFrame: (CGRect) headerFrame andTitle:(NSString *) title;

- (void)addTextField:(UITextField *) textFiled OnView:(UIView *) formView  withFrame : (CGRect) frame andText:(NSString *) title;

- (void)addDatesButtonsOnView:(UIView *) formView withFrame: (CGRect) frame;

- (void)addDatesOnView: (UIView *)formView withFrame:(CGRect) frame;

-(UILabel *) addLabel:(CGRect) frame : (NSString *) text;

-(void) addDateLabel:(UILabel *) label onView:(UIView *) formView withFrame: (CGRect) frame;

- (void)addButtonOnFromView:(UIView *)formView withFrame: (CGRect)frame andTitle:(NSString *) title andMethod:(SEL) methodSelector;

- (void) createSlotWithDate: (NSDate *) firstDate endDate:(NSDate *) endDate;

@end
