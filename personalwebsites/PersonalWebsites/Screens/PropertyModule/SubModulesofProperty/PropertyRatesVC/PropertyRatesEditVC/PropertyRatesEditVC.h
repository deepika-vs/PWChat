//
//  PropertyRatesEditVC.h
//  PersonalWebsites
//
//  Created by VectoScalar on 17/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWButton.h"
#import "PWTextField.h"
#import "RateWrapper.h"
#import "DatePickerView.h"
#import "BaseViewController.h"

@protocol PropertyRatesEditVCDelegate <NSObject>

- (void)addOrUpdateRateWithRecord:(RateWrapper *) rateRecord atIndex: (NSInteger) index;

@end

@interface PropertyRatesEditVC : BaseViewController <DatePickerViewDelegate>{
    NSUInteger tagNum;
}

@property (weak, nonatomic) IBOutlet UIScrollView *mEditRateScrlV;

@property (weak, nonatomic) IBOutlet UIView *editRatesView;
@property (weak, nonatomic) IBOutlet UIView *editRateFiledsView;

@property (weak, nonatomic) IBOutlet UIView *seasonView;
@property (weak, nonatomic) IBOutlet PWTextField *seasonTF;

//Dates
@property (weak, nonatomic) IBOutlet UIView *dateview;

@property (weak, nonatomic) IBOutlet UIView *startDateView;
@property (weak, nonatomic) IBOutlet UIButton *sDateBtn;

@property (weak, nonatomic) IBOutlet UIView *endDateView;
@property (weak, nonatomic) IBOutlet UIButton *endDateBtn;

@property (weak, nonatomic) IBOutlet UIView *wkEndNightView;
@property (weak, nonatomic) IBOutlet PWTextField *wkEndNigtTF;

@property (weak, nonatomic) IBOutlet UIView *wkNightView;
@property (weak, nonatomic) IBOutlet PWTextField *wkNightTF;

@property (weak, nonatomic) IBOutlet UIView *wkAndMonRateView;
@property (weak, nonatomic) IBOutlet UIView *weekRateView;
@property (weak, nonatomic) IBOutlet PWTextField *wkRateTF;

@property (weak, nonatomic) IBOutlet UIView *monthRateView;
@property (weak, nonatomic) IBOutlet PWTextField *monthRateTF;

@property (weak, nonatomic) IBOutlet UIView *minStayView;
@property (weak, nonatomic) IBOutlet PWTextField *minStayTF;

@property (assign, nonatomic) NSInteger rowIndex;
@property (strong, nonatomic) RateWrapper *rateRecord;
@property (assign, nonatomic) id <PropertyRatesEditVCDelegate> delegate;

@property (weak, nonatomic) IBOutlet PWButton *insertBtn;

- (IBAction)pickDate:(UIButton *)sender;
- (IBAction)insertButtonPressed:(PWButton *)sender;

@end
