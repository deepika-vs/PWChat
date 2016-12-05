//
//  AddIcalPropertyVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 15/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "AddIcalPropertyVC.h"
#import "DropDownMenuView.h"

#define kIcalLinkScreenTitle     @"Add Ical Link"

#define kDownArrowFont           16
#define kHeadtingTopConstraint  -75
#define kXpadding 12


@interface AddIcalPropertyVC ()<UITextFieldDelegate,DropDownMenuDelegate>
{
    NSString *selectedListItem;
}


@end

@implementation AddIcalPropertyVC
@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.needToShowBackButton = YES;
    
    [self createNavigationBarLeftItems];
    
    selectedListItem = @"";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self configureUI];
    
    if(self.icalLinkRecord){
        [self updateIcalLinkFieldsContentToEdit];
    }
    
    [self setVisibilityOfRequiredFieldsMsgLbl: YES];
    
    // Do any additional setup after loading the view from its nib.
}



- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Hide required input messages fields.
}




- (void) setVisibilityOfRequiredFieldsMsgLbl: (BOOL) isVisible{
    
    self.requiredPropertyMsgLbl.hidden = isVisible;
    self.requiredHeadMsgLbl.hidden = isVisible;
    self.requiredLinkMsgLbl.hidden = isVisible;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)configureUI
{
    self.propertyIDLlb.backgroundColor = kInputFieldBGColor;
    
    [Utility makeRoundedBorderOnView:self.listView];
    [Utility makeRoundedBorderOnView:self.headingView];
    [Utility makeRoundedBorderOnView:self.icalView];
    [Utility makeRoundedBorderOnView:self.propertyIDTextView];
    
    self.listView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.listView.layer.borderWidth = 1.0f;
    self.listView.layer.cornerRadius = 4.0f;
    
    self.downArrowLabel.font = kFontAwesomeFont(kDownArrowFont);
    self.downArrowLabel.text = kFontAwesomeText(kDownArrowFA);
    
    //Add TapGesture to list
    
    
    if(!self.icalLinkRecord)
    {
        [self addTapGestureToListView];
        self.navigationItem.title = kIcalLinkScreenTitle;
        self.contentViewToConstraint.constant = 0;
        self.propertyIDView.hidden = YES;
    }
    else
    {
        //self.propertySelectionTitle.hidden = YES;
        self.downArrowLabel.hidden = YES;
        
        //self.listView.hidden = YES;
        //_headingTopConstraint.constant = kHeadtingTopConstraint;
        self.navigationItem.title = self.pageTitle;
    }
    
}


- (void)updateIcalLinkFieldsContentToEdit{
    
    [self.headingTextField setText:self.icalLinkRecord.heading];
    [self.icalTextField setText:self.icalLinkRecord.link];
    [self.listItemLabel setText:self.icalLinkRecord.name];
    [self.propertyIDLlb setText:self.icalLinkRecord.propertyid];
    selectedListItem = self.icalLinkRecord.name;
    
    //To disable property name.
    self.listItemLabel.alpha = 0.6;
}


- (void)addTapGestureToListView
{
    if(self.downArrowLabel.isHidden){
        return;
    }
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnListView)];
    [self.listView addGestureRecognizer:gesture];
}



#pragma mark - Handle tap of List View

- (void)userTappedOnListView
{
    
    NSArray *menu  = [NSArray arrayWithObjects:@"First",@"Second",@"Third", nil];
    
    CGRect frame = self.listView.frame;
    frame.origin.x = kXpadding;
    
    DropDownMenuView *menuView = [[DropDownMenuView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) andListViewFrame:frame andMenuList:menu];
    
    menuView.delegate = self;
    
    [self.view addSubview:menuView];
}




- (IBAction)userPressedSubmitButton:(id)sender {
    
    if([self isAllInputFieldsValid]){
        
        [self updateIcalLinkFieldsContent];
        
        [delegate userAddOrUpdateIcalPropertyWithContent:self.icalLinkRecord atRowIndex:self.rowIndex];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}



//Add new Or modifiy icallink content.

- (void) updateIcalLinkFieldsContent{
    //Prepare review's data.
    if(!self.icalLinkRecord){
        //Create a new record and add it to entity data.
        self.icalLinkRecord = (IcalLink *)[DataManager insertRecordToEntityName: kIcalLinkEntiry];
        self.icalLinkRecord.name = selectedListItem;
    }
    
    self.icalLinkRecord.heading = self.headingTextField.text;
    self.icalLinkRecord.link = self.icalTextField.text;
}




- (BOOL) isAllInputFieldsValid{
    
    BOOL isFieldRequired = NO;
    
    NSString *heading = [Utility trimWhiteSpacesAndNewLinesFromString: self.headingTextField.text];
    
    NSString *icalLink = [Utility trimWhiteSpacesAndNewLinesFromString: self.icalTextField.text];
    
    
    if([selectedListItem length] == 0){
        self.requiredPropertyMsgLbl.hidden = NO;
        isFieldRequired = YES;
    }else{
        self.requiredPropertyMsgLbl.hidden = YES;
    }
    
    
    if([heading length] == 0){
        self.requiredHeadMsgLbl.hidden = NO;
        isFieldRequired = YES;
    }else{
        self.requiredHeadMsgLbl.hidden = YES;
        [self.headingTextField setText:heading];
    }
    
    
    if([icalLink length] == 0){
        self.requiredLinkMsgLbl.hidden = NO;
        isFieldRequired = YES;
    }else{
        self.requiredLinkMsgLbl.hidden = YES;
        [self.icalTextField setText:icalLink];
    }
    
    return !isFieldRequired;
}



#pragma  mark -UITextfiedl Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.headingTextField)
    {
        [self.icalTextField becomeFirstResponder];
    }
    else
    {
        [self.view endEditing:YES];
    }
    
    return YES;
}


#pragma mark - Drop Down Menu Delegate

- (void)didUserSelectedMenuOption:(NSString *)selectedOption
{
    self.listItemLabel.text = selectedOption;
    selectedListItem = selectedOption;
}

@end
