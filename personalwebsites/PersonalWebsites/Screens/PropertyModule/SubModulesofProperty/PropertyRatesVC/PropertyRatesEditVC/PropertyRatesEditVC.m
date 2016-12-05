//
//  PropertyRatesEditVC.m
//  PersonalWebsites
//
//  Created by VectoScalar on 17/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "PropertyRatesEditVC.h"
#import "DatePickerView.h"

#define kScreenEditRateTitle  @"Property Rate"
#define kBackGroundColor      [UIColor colorWithRed:242.0/255.0f green:242.0/255.0f blue:242.0/255.0f alpha:1.0]
#define kCornerRadious        4.0f


@interface PropertyRatesEditVC ()<UITextFieldDelegate>

@end

@implementation PropertyRatesEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.needToShowBackButton = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.title = kScreenEditRateTitle;
    
    [self createNavigationBarLeftItems];
    
    [self configureView];
    
    if(self.rateRecord){
        [self updateRateAttributesBeforeEdit];
    }
    // Do any additional setup after loading the view from its nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)configureView
{
    [Utility makeRoundedBorderOnView:self.seasonView];
    [Utility makeRoundedBorderOnView:self.wkEndNightView];
    [Utility makeRoundedBorderOnView:self.wkNightView];
    [Utility makeRoundedBorderOnView:self.minStayView];
    
    [self makeRoundedBorderTextFiled:self.wkRateTF];
    [self makeRoundedBorderTextFiled:self.monthRateTF];
    
    [self makeRoundedBorderButtonView:self.sDateBtn];
    [self makeRoundedBorderButtonView:self.endDateBtn];
    
    //Add keyboard type to field.
    [self.seasonTF setKeyboardType: UIKeyboardTypeDefault];
    [self.monthRateTF setKeyboardType: UIKeyboardTypeNumberPad];
    [self.wkRateTF setKeyboardType: UIKeyboardTypeNumberPad];
    [self.wkEndNigtTF setKeyboardType: UIKeyboardTypeNumberPad];
    [self.wkNightTF setKeyboardType: UIKeyboardTypeNumberPad];
    [self.minStayTF setKeyboardType: UIKeyboardTypeNumberPad];
}



- (void)makeRoundedBorderButtonView:(UIButton*) buttonView
{
    buttonView.layer.cornerRadius = kCornerRadious;
    buttonView.backgroundColor = kBackGroundColor;
}



- (void)makeRoundedBorderTextFiled:(UITextField*) textFiledView
{
    textFiledView.layer.cornerRadius = kCornerRadious;
    textFiledView.backgroundColor = kBackGroundColor;
}


- (void)updateRateAttributesBeforeEdit{
    [self.seasonTF setText:self.rateRecord.season];
    [self.wkNightTF setText:self.rateRecord.wkNightRate];
    [self.wkEndNigtTF setText:self.rateRecord.wkdNihtRate];
    [self.wkRateTF setText:self.rateRecord.weeklyNightRate];
    [self.monthRateTF setText:self.rateRecord.monthlyRate];
    [self.minStayTF setText:self.rateRecord.minStay];
    [self.sDateBtn setTitle:self.rateRecord.startDate forState:UIControlStateNormal];
    [self.endDateBtn setTitle:self.rateRecord.endDate forState:UIControlStateNormal];
}



- (IBAction)pickDate:(UIButton *)sender
{
    [self.editRateFiledsView endEditing:YES];
    
    DatePickerView *dateView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    dateView.delegate = self;
    tagNum = sender.tag;
    [self.view addSubview:dateView];
}



-(void) didUserPickedDate:(NSString *)date{
    switch (tagNum) {
        case 201:
            [_sDateBtn setTitle: date forState: UIControlStateNormal];
            break;
        case 202:
            [_endDateBtn setTitle: date forState: UIControlStateNormal];
            break;
        default:
            break;
    }
}



#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.seasonTF)
    {
        [self.view endEditing:YES];
    }
    else if(textField == self.wkEndNigtTF)
    {
        [self.wkNightTF becomeFirstResponder];
    }
    else if(textField == self.wkNightTF)
    {
        [self.wkRateTF becomeFirstResponder];
    }
    else if(textField == self.wkRateTF)
    {
        [self.monthRateTF becomeFirstResponder];
    }
    else if(textField == self.monthRateTF)
    {
        [self.minStayTF becomeFirstResponder];
    }
    else
    {
        [self.view endEditing:YES];
    }
    
    return YES;
}


- (IBAction)insertButtonPressed:(PWButton *)sender {
    if([self isAllInputValid]){
        [self saveRateAttributes];
        
        [self.delegate addOrUpdateRateWithRecord:self.rateRecord atIndex:self.rowIndex];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (BOOL) isAllInputValid{
    //TODO:: Connect with error message required field.
    BOOL isValidInput = YES;
    
    if([Utility isNumericValue:self.wkRateTF.text] || [self.wkRateTF.text floatValue] >= 0){
        
    }else{
        //error message
    }
    
    
    if([Utility isNumericValue:self.wkRateTF.text] || [self.wkRateTF.text floatValue] >= 0){
        
    }else{
        //error message
    }
    
    
    if([Utility isNumericValue:self.wkNightTF.text] || [self.wkNightTF.text floatValue] >= 0){
        
    }else{
        //error message
    }
    
    if([Utility isNumericValue:self.wkEndNigtTF.text] || [self.wkEndNigtTF.text floatValue] >= 0){
        
    }else{
        //error message
    }
    
    if([Utility isNumericValue:self.monthRateTF.text] || [self.monthRateTF.text floatValue] >= 0){
        
    }else{
        //error message
    }
    
    if([Utility isNumericValue:self.minStayTF.text] || [self.minStayTF.text floatValue] >= 0){
        
    }else{
        //error message
    }
    
    
    NSString *startDateStr = self.sDateBtn.currentTitle;
    NSString *endDateStr = self.endDateBtn.currentTitle;
    
    
    if([startDateStr length] >0 && [startDateStr length] && [startDateStr compare:endDateStr options:NSCaseInsensitiveSearch] == NSOrderedAscending){
        
    }else{
        //error message
    }
    
    if([self.endDateBtn.currentTitle length] >0){
        
    }else{
        //error message
    }
    
    //TODO::to implement validation of input fields.
    return isValidInput;
}


- (void)saveRateAttributes{
    
    if(!self.rateRecord){
        self.rateRecord = [[RateWrapper alloc] init];
    }
    
    self.rateRecord.season = self.seasonTF.text;
    self.rateRecord.wkNightRate = self.wkNightTF.text;
    self.rateRecord.wkdNihtRate = self.wkEndNigtTF.text;
    self.rateRecord.weeklyNightRate = self.wkRateTF.text;
    self.rateRecord.monthlyRate = self.monthRateTF.text;
    self.rateRecord.startDate = self.sDateBtn.currentTitle;
    self.rateRecord.endDate = self.endDateBtn.currentTitle;
    self.rateRecord.minStay = self.minStayTF.text;
    
    [self.delegate addOrUpdateRateWithRecord:self.rateRecord atIndex:self.rowIndex];
}
@end
