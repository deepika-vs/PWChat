//
//  ContactDetailsVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 26/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "ContactDetailsVC.h"
#import "MapViewVC.h"

#define kMapViewVC                  @"MapViewVC"
#define kScreenName                 @"Contact"
#define kAddressPlaceholder         @"Address"
#define kEmailPlaceholder           @"Email"
#define kPhonePlaceholder           @"Phone"
#define kLatPlaceholer              @"Latitude"
#define kLonnPlaceholder            @"Longitude"

#define kEmailFontAwesomeIcon       @"fa-envelope"
#define kPhoneFontAwesomeIcon       @"fa-phone"
#define kAddressFontAwesomeIcon     @"fa-map-signs"
#define kLocFontAwesomeIcon         @"fa-map-marker"

#define kEmailAlertMsg              @"Please enter email"
#define kEmailValidateMsg           @"Please enter valid email"
#define kAlertPhoneValidateMsg      @"Please enter valid phone number"
#define kAlertAddressMsg            @"Please enter address"
#define kAlertCoordinateMsg         @"Please enter valid coordinates"

#define kIconColor                  [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:0.8]

@interface ContactDetailsVC ()<UITextFieldDelegate, MapViewVCDelegate, UITextViewDelegate>{
    
    NSString *contactAddress;
}

@end

@implementation ContactDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self configureViews];
    self.needToShowBackButton = YES;
    self.navigationItem.title  = kScreenName;
    [self createNavigationBarLeftItems];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    [self changePlaceholderColor];
    [self addContactFieldsIcon];
    
    [self hideAndShowReqInputFieldsMsgLbls: YES];
    
    contactAddress = kEmptyStr;
    // Do any additional setup after loading the view from its nib.
}



- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void) hideAndShowReqInputFieldsMsgLbls:(BOOL) isHide{
    self.reqEmailMgsLbl.hidden = isHide;
    self.reqPhoneMgsLbl.hidden = isHide;
    self.reqAddressMgsLbl.hidden = isHide;
    self.reqLatMgsLbl.hidden = isHide;
    self.reqLngMgsLbl.hidden = isHide;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //Open keyboard according its type.
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;

    NSLog(@"%@",NSStringFromCGSize(self.mScrollView.contentSize));

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Add contact's details filed icons.
- (void)changePlaceholderColor
{
    [Utility changePlaceholderTextColor:self.emailTextField withColor:[UIColor lightGrayColor] containsPlaceholderText:kEmailPlaceholder];
    
    [Utility changePlaceholderTextColor:self.phoneTextField withColor:[UIColor lightGrayColor] containsPlaceholderText:kPhonePlaceholder];
}


//Add icons to contact's fileds.
- (void) addContactFieldsIcon{
    
    self.emailIcon.image = [UIImage imageWithIcon:kFontAwesomeText(kEmailFontAwesomeIcon) backgroundColor:[UIColor clearColor] iconColor:kIconColor andSize:CGSizeMake(18, 18)];
    
    self.phoneIcon.image = [UIImage imageWithIcon:kFontAwesomeText(kPhoneFontAwesomeIcon) backgroundColor:[UIColor clearColor] iconColor:kIconColor andSize:CGSizeMake(18, 18)];
    
    self.addressIcon.image = [UIImage imageWithIcon:kFontAwesomeText(kAddressFontAwesomeIcon) backgroundColor:[UIColor clearColor] iconColor:kIconColor andSize:CGSizeMake(18, 18)];
    
    self.latitudeIcon.image = [UIImage imageWithIcon:kFontAwesomeText(kLocFontAwesomeIcon) backgroundColor:[UIColor clearColor] iconColor:kIconColor andSize:CGSizeMake(18, 18)];
    
    self.longitudeIcon.image = [UIImage imageWithIcon:kFontAwesomeText(kLocFontAwesomeIcon) backgroundColor:[UIColor clearColor] iconColor:kIconColor andSize:CGSizeMake(18, 18)];
}



- (void)configureViews
{
    [self.mScrollView setContentSize:CGSizeMake(kScreenWidth, kScreenHeight-64)];
    
    [Utility makeRoundedBorderOnView:self.emailView];
    [Utility makeRoundedBorderOnView:self.phoneView];
    [Utility makeRoundedBorderOnView:self.addressView];
    [Utility makeRoundedBorderOnView:self.latitudeView];
    [Utility makeRoundedBorderOnView:self.longitudeView];
}


#pragma mark - Local Methods

- (IBAction)didPressSelectMapButton:(id)sender {
    
    MapViewVC *mapView = [[MapViewVC alloc] initWithNibName:kMapViewVC bundle:nil];
    
    mapView.delegate = self;
    
    [self presentViewController:mapView animated:YES completion:nil];
}



- (IBAction)userPressedSubmitButton:(id)sender {
    
    if([self isAllInputValid])
    {
        [Utility showAlerWithMessage:@"All Good :)" onViewController:self];
    }
}



- (BOOL)isAllInputValid
{
    BOOL isFiledRequired = NO;
    
    if([Utility isEmptyOrNilForString:self.emailTextField.text] || [Utility isVaildEmail:self.emailTextField.text] == NO){
        self.reqEmailMgsLbl.hidden = NO;
        isFiledRequired = YES;
    }else{
        self.reqEmailMgsLbl.hidden = YES;
    }
    
    if([Utility isEmptyOrNilForString:self.phoneTextField.text] || [Utility isValidPhoneNumber:self.phoneTextField.text] == NO){
        self.reqPhoneMgsLbl.hidden = NO;
        isFiledRequired = YES;
    }else{
        self.reqPhoneMgsLbl.hidden = YES;
    }
    
    if([Utility isEmptyOrNilForString:self.addressTextView.text]){
        self.reqAddressMgsLbl.hidden = NO;
        isFiledRequired = YES;
    }else{
        self.reqAddressMgsLbl.hidden = YES;
    }
    
    
    if(![Utility isStringDecimalNumber:self.latitudeButton.titleLabel.text] || ![Utility isStringDecimalNumber:self.longitudeButton.titleLabel.text]){
        self.reqLatMgsLbl.hidden = NO;
        isFiledRequired = YES;
    }else{
        self.reqLatMgsLbl.hidden = YES;
    }
    
    
    return !isFiledRequired;
}


- (void)textViewDidChange:(UITextView *)textView {
 
}

#pragma mark - UIText Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField ==  self.phoneTextField)
    {
        NSString *enteredText = [self.phoneTextField.text stringByReplacingCharactersInRange:range withString:string];
        
        if(enteredText.length > 10)
        {
            return NO;
        }
        
        if(![Utility isNumericValue:string] && ![string isEqualToString:@""])
        {
            return NO;
        }
    }
    return YES;
}


#pragma mark - Customize TextFIeldContainer

- (void)makeRoundedBorderOnView:(UIView*)view
{
    view.layer.cornerRadius = 4.0f;
    //  view.layer.borderWidth = 0.8f;
    // view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //Add Tag Gesture to Lat long View
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPressSelectMapButton:)];
    [self.latitudeView addGestureRecognizer:gesture];
    
    UITapGestureRecognizer *lngGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPressSelectMapButton:)];
    [self.longitudeView addGestureRecognizer:lngGesture];
    
}


#pragma mark - MapViewDelegate

- (void)userDidSelectedLocation:(CLLocation *)location withAddress:(NSString *)address
{
    [self.latitudeButton setTitle:[NSString stringWithFormat:@"%f",location.coordinate.latitude] forState:UIControlStateNormal];
    
     [self.longitudeButton setTitle:[NSString stringWithFormat:@"%f",location.coordinate.longitude] forState:UIControlStateNormal];
    
    
    [self.latitudeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.longitudeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}


#pragma mark - UITextView Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:kAddressPlaceholder])
    {
        textView.text  = kEmptyStr;
        textView.textColor = [UIColor blackColor];
    }
    
    return YES;
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSString *textViewString = [Utility trimWhiteSpacesAndNewLinesFromString:textView.text];
    
    if([textViewString isEqualToString:kEmptyStr])
    {
        textView.text  = kAddressPlaceholder;
        textView.textColor = [UIColor lightGrayColor];
    }
    
    contactAddress = textView.text;
    return YES;
}


#pragma mark - Textfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.emailTextField)
    {
        [self.phoneTextField becomeFirstResponder];
    }
    if(textField == self.phoneTextField)
    {
        [self.addressTextView becomeFirstResponder];
        return NO;
    }
    
    return YES;
}


//#pragma -mark UITextView Delegate <Methods>
//- (void)textViewDidBeginEditing:(UITextView *)textView{
//    textView.showsVerticalScrollIndicator = YES;
//}
@end
