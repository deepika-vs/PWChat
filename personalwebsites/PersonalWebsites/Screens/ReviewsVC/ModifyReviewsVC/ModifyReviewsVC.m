//
//  ModifyReviewsVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 17/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "ModifyReviewsVC.h"
#import "ReviewWrapper.h"
#import "DropDownMenuView.h"

#define kScreenTitle            @"Reviews"
#define kActionSheetTakePhoto   @"Take Photo"
#define kActionSheetPickPhoto   @"Photo Library"
#define kActionSheetCancel      @"Cancel"

#define kYPadding           8
#define kDownArrowFont      18
#define kMaxHeight          200
#define kContentViewHeight  47


@interface ModifyReviewsVC ()<UITextFieldDelegate,DropDownMenuDelegate, UIGestureRecognizerDelegate,RichTextBaseControllderDelegate,UIWebViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{

}

@end


@implementation ModifyReviewsVC
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.needToShowBackButton = YES;
    [self createNavigationBarLeftItems];
    
    self.navigationItem.title = kScreenTitle;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.mWebView.delegate = self;
    
    [self configureUI];
    
    //Update fields if user want to edit a review.
    if(self.reviewWrapper){
        [self updateFieldsToEditReview];
    }
    
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Set background color of uiwebview.
    self.mWebView.backgroundColor = kInputFieldBGColor;
    
    self.mWebView.layer.cornerRadius = 4.0;
    self.mWebView.opaque = NO;
}


- (void)configureUI
{
    [Utility makeRoundedBorderOnView:self.customerNameView];
    [Utility makeRoundedBorderOnView:self.headingView];
    [Utility makeRoundedBorderOnView:self.customerPlaceView];
    [Utility makeRoundedBorderOnView:self.contentView];
    [Utility makeRoundedBorderOnView:self.listView];
    
    self.downArrowIconlabel.font = kFontAwesomeFont(kDownArrowFont);
    self.downArrowIconlabel.text = kFontAwesomeText(kDownArrowFA);
    
    //Set scroll view enable to webview.
    self.mWebView.scrollView.scrollEnabled = YES;
    self.mWebView.contentMode = UIViewContentModeScaleAspectFit;
    
    //Add edit button font-awesome title.
    [Utility addFAUIOnButton:self.editButton andFATitle:kEditFAIcon andColor:kNavColor andFont:kFAIconSize];
    
    //Add tap gesture to list view
    [self addTapGestureToListView];
    
    //Add Tap Gesture to image View
    [self addTapGestureToImageView];
    
    //Hide required input messages fields.
    [self setVisibilityOfRequiredFieldsMsgLbl: YES];
}


- (void)setVisibilityOfRequiredFieldsMsgLbl:(BOOL) isVisible{
    //Hide validator msg fields.
    self.nameRequireLbl.hidden = isVisible;
    self.headingRequireLbl.hidden = isVisible;
    self.placeRequireLbl.hidden = isVisible;
    self.prtNameRequireLbl.hidden = isVisible;
    self.contentRequireLbl.hidden = isVisible;
}



- (void)addTapGestureToListView
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedListView)];
    
    [self.listView addGestureRecognizer:gesture];
}



- (void)addTapGestureToImageView
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedImageView)];
    
    [self.userImageContainerView addGestureRecognizer:gesture];
}



- (void)userTappedImageView
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:kActionSheetCancel destructiveButtonTitle:kActionSheetTakePhoto otherButtonTitles:kActionSheetPickPhoto,nil];
    
    popup.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [popup showInView:self.view];
    
}



- (void)userTappedListView
{
    
    [self.view endEditing:YES];
    
    //TODO: Hard coded data will update.
    NSArray *arr = [NSArray arrayWithObjects:@"Delhi", @"Mumbai", @"Jaipiur", @"Goa", nil];
    
    DropDownMenuView *dropDownView = [[DropDownMenuView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.mScrollView.contentSize.height)  andListViewFrame:self.listView.frame andMenuList:arr];
    
    dropDownView.delegate = self;
    
    [self.mScrollView addSubview:dropDownView];
}




- (IBAction)userPressedEditButton:(UIButton *)sender {
    [self openTextEditor];
}


- (void)openTextEditor
{
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    RichTextBaseController *editorVC = [[RichTextBaseController alloc] init];
    editorVC.delegate = self;
    editorVC.screenTitle = kScreenTitle;
    
    [editorVC setHTML:self.reviewHtmlContent];
    
    [self.navigationController pushViewController:editorVC animated:NO];
}



- (IBAction)userPressedSubmitButton:(id)sender {
    
    if([self isAllInputValid] == YES){
        
        //Add new review Or modifiy reivew.
        [self updateReviewContent];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}



- (BOOL) isAllInputValid{
    
    BOOL isFieldRequired = YES;
    
    NSString *name = [Utility trimWhiteSpacesAndNewLinesFromString:self.customerNameTextField.text];
    NSString *heading = [Utility trimWhiteSpacesAndNewLinesFromString:self.headingTextField.text];
    NSString *place = [Utility trimWhiteSpacesAndNewLinesFromString:self.customerPlaceTextField.text];
    NSString *content = [Utility trimWhiteSpacesAndNewLinesFromString:[Utility getPlanTextFromHTMLText: self.mWebView]];

    
    if([name length] == 0){
        self.nameRequireLbl.hidden = NO;
        isFieldRequired = YES;
    }else{
        [self.customerNameTextField setText:name];
        self.nameRequireLbl.hidden = YES;
    }
    
    if([heading length] == 0){
        self.headingRequireLbl.hidden = NO;
        isFieldRequired = YES;
    }else{
        [self.headingTextField setText:heading];
        self.headingRequireLbl.hidden = YES;
    }
    
    if([place length] == 0){
        isFieldRequired = YES;
        self.placeRequireLbl.hidden = NO;
    }else{
        [self.customerPlaceTextField setText:place];
        self.placeRequireLbl.hidden = YES;
    }
    
    if([content length] == 0){
        self.contentRequireLbl.hidden = NO;
        isFieldRequired = YES;
    }else{
        self.contentRequireLbl.hidden = YES;
    }
    
    
    if([Utility isEmptyOrNilForString:self.selectedPropertyName]){
        isFieldRequired = YES;
        self.prtNameRequireLbl.hidden = NO;
    }else{
        self.prtNameRequireLbl.hidden = YES;
    }
    
    
    if(!self.userImageView.image){
        isFieldRequired = YES;
    }
    
    
    return !isFieldRequired;
}



//Validate user inputs.
- (BOOL) validateOnInput:(NSString *) text{
    if([text length] == 0){
        return YES;
    }
    
    return NO;
}


//Add new review Or modifiy reivew.

- (void) updateReviewContent{
    //Prepare review's data.
    
    ReviewWrapper *reviewContent = [[ReviewWrapper alloc] init];
    
    reviewContent.customerName = self.customerNameTextField.text;
    reviewContent.heading = self.headingTextField.text;
    reviewContent.address = self.customerPlaceTextField.text;
    reviewContent.propertyName = self.listItemLabel.text;
    
    reviewContent.content = [Utility getPlanTextFromHTMLText:self.mWebView];
    
    reviewContent.customerProfileImg = self.userImageView.image;
    
    [delegate userAddNewOrEditReviewWithContents:reviewContent atRowIndex:self.rowIndex];
}




- (void) updateFieldsToEditReview{
    
    self.customerNameTextField.text = self.reviewWrapper.customerName;
    self.headingTextField.text = self.reviewWrapper.heading;
    self.customerPlaceTextField.text = self.reviewWrapper.address;
    self.listItemLabel.text = self.reviewWrapper.propertyName;
    self.selectedPropertyName = self.reviewWrapper.propertyName;
    
    self.reviewHtmlContent = [NSString stringWithFormat:@"<html> <body></br> %@ </bod> </html>", self.reviewWrapper.content];
    
    self.userImageView.image = self.reviewWrapper.customerProfileImg;
    
    [self loadHTMLContentToWebView];
    
    self.imageActionlabel.text = @"Edit";
}


#pragma mark - Gesture Delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        [otherGestureRecognizer requireGestureRecognizerToFail:gestureRecognizer];
        
        if([gestureRecognizer.view class] == [UIWebView class])
        {
            // [self openTextEditor];
        }
        
    }
    
    return YES;
    
}



#pragma mark - Text Fiedl Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if(textField == self.customerNameTextField)
    {
        [self.headingTextField becomeFirstResponder];
    }
    else if (textField == self.headingTextField)
    {
        [self.customerPlaceTextField becomeFirstResponder];
    }
    else
    {
        [self.view endEditing:YES];
    }
    
    return YES;
}


#pragma mark - Rich Text Editor Delegate

- (void)userDidSavedHTMLContent:(NSString *)htmlContent
{
    if(htmlContent.length > 0){
        self.reviewHtmlContent = htmlContent;
        [self loadHTMLContentToWebView];
    }
}


//Load HTML content to uiwebview.
-(void) loadHTMLContentToWebView{
    if([self.reviewHtmlContent length] > 0){
        //Set font-family & size;
        self.reviewHtmlContent = [Utility setWebViewHTMLTextFont: self.reviewHtmlContent];
        
        //Set text to uiwebview.
        [self.mWebView loadHTMLString:self.reviewHtmlContent baseURL:nil];
        
    }
}

#pragma mark - Image Pickcer Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0)
    {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController* picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            // picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,kUTTypeImage,nil];
            
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:NULL];
        }
        else
        {
            
            
            UIAlertView *altnot=[[UIAlertView alloc]initWithTitle:@"Camera Not Available" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [altnot show];
            
        }
        
    } else if (buttonIndex == 1) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,kUTTypeImage,nil];
        
        picker.delegate = self;
        picker.editing = YES;
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
    
}



- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    NSData * imagedata = UIImageJPEGRepresentation(image, 0.3);
    
    UIImage *img = [UIImage imageWithData:imagedata];
    
    self.userImageView.image = img;
    
    if(img){
        self.imageActionlabel.text = @"Edit";
    }
    
}


#pragma mark - Drop Down Menu Delegate
- (void)didUserSelectedMenuOption:(NSString *)selectedOption
{
    self.listItemLabel.text = selectedOption;
    self.selectedPropertyName = selectedOption;
}

@end
