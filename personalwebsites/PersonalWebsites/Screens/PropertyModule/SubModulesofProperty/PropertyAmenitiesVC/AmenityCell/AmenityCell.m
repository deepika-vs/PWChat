//
//  AmenityCell.m
//  PersonalWebsites
//
//  Created by VectoScalar on 22/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "AmenityCell.h"
#import "AddAmenituView.h"

#define kXPadding               10.0
#define kYPadding               6.0
#define kGap                    10.0
#define kBottomMargin           8.0
#define kViewAmenityMargin      24.0

#define kFontStyle              @"Helvetica" //Arial
#define kFontSize               14.0f
#define kLabelHeight            25.0f
#define kDelAmenityBtnSize      35.0f

#define kDownArrowFont          14.0
#define kCrossBtnTitle          @"fa-times"

#define kCrossBtnTextColor      [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]
#define kAmenityTextColor       [UIColor colorWithRed:88.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0]

#define kDelCategoryMsg         @"Are you sure, you want to delete the category?"
#define kDelAmenityMsg          @"Are you sure, you want to delete the amenity?"
#define kPlaceHolderText        @"Amenity name"
#define kAddANewAmenity         @"Add a new amenity"
#define kAddAmenity             @"Add amenity"

#define kAddNewAmenityMessage   @"Enter a new amenity name for category"
#define kAddAmenityMsg          @"Please add amenity data"

#define kDelAmenityBtnBaseTag   87987
#define kDelCategoryBtnTag      20511

#define kXpadingAmenityView     40.0f
#define kAddAmenityViewHeight   200.0f
#define kBtnBackColor           kNavColor
#define kAddNewAmenityBtnWidth  115.0f
#define kAddNewAmenityBtnHeight 25.0f

@implementation AmenityCell
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    //Set shadow & corner radious to view.
    [Utility addShadowToView:self.contentsView];
    
    //Configure delete's button UI & add title.
    [Utility addFAUIOnButton:self.deleteCateBtn andFATitle:kTrashFA andColor:[UIColor redColor] andFont:18];
    
    //Set delete button's title edge insets.
    self.deleteCateBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 30, 5, 5);
    
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



- (void)addAmenitiesToCell:(NSArray *) amenitiesArray withCellWidth:(CGFloat)cellWidth {

    for(UIView *view in self.amenitiesView.subviews)
    {
        [view removeFromSuperview];
    }
    
    
    CGFloat xPos = kXPadding;
    CGFloat yPos = kYPadding;
    
    CGFloat maxLabelWidth = cellWidth - (2 * kXPadding + kViewAmenityMargin);
    CGFloat adjMaxWidth = maxLabelWidth;
    
    int index = 0;
    
    for(NSString *amenity in amenitiesArray){
        //create view and add amenity to cell.
        UIFont *font = [UIFont fontWithName:kFontStyle size:kFontSize];
        CGSize size = [Utility getTheSizeForTextFixedHeight:amenity andFont:font toFitInHeight:kLabelHeight];
        //Add label to amenities category.
        UIView *chipsView = [[UIView alloc] initWithFrame:CGRectZero];
        CGRect rectView = CGRectMake(xPos, yPos, 0.0, 0.0);
        rectView.size.width = size.width + kDelAmenityBtnSize;
        //Add label.
        UILabel *amenityLbl = [[UILabel alloc] initWithFrame:CGRectZero];
        amenityLbl.text = amenity;
        amenityLbl.font = font;
        amenityLbl.textColor = kAmenityTextColor;
        amenityLbl.alpha = 0.7f;
        
        //Check if text size is greater than maxLabelWidth.
        if(rectView.size.width > maxLabelWidth)
        {
            int nLine = (int)ceil(size.width / maxLabelWidth);
            
            amenityLbl.lineBreakMode = YES;
            amenityLbl.numberOfLines = nLine;
            
            if(xPos != kXPadding){
                yPos += kLabelHeight + kGap;
            }
            
            xPos = kXPadding;
            rectView.origin.x = xPos;
            rectView.origin.y = yPos;
            rectView.size.width = maxLabelWidth;
            rectView.size.height = kLabelHeight * nLine;
            yPos+= kLabelHeight * (nLine - 1);
        }
        else
        {
            //if size is less than availabel spave
            if(rectView.size.width <= adjMaxWidth)
            {
                rectView.origin.x = xPos;
                rectView.origin.y = yPos;
            }else{
                rectView.origin.x = kXPadding;
                rectView.origin.y = yPos + kLabelHeight + kGap;
                adjMaxWidth = maxLabelWidth;
            }
            
            rectView.size.height = kLabelHeight;
            yPos = rectView.origin.y;
            xPos = rectView.origin.x + rectView.size.width + kGap;
        }
        
        CGRect lblRect = CGRectZero;
        lblRect.size.width = rectView.size.width - kDelAmenityBtnSize;
        lblRect.size.height = rectView.size.height;
        lblRect.origin.x = 5.0;
        
        amenityLbl.frame = lblRect;
        //lbl.frame
        chipsView.backgroundColor = [UIColor whiteColor];
        [self addShadowOn:chipsView];
        
        chipsView.frame = rectView;
        [chipsView addSubview:amenityLbl];
        
        CGRect delBtnFrame = CGRectMake((rectView.size.width - kDelAmenityBtnSize + 3),
                                        0.0,
                                        kDelAmenityBtnSize - 3,
                                        rectView.size.height);
        //Add deletebtn to amenity.
        [self addDeleteAmenityBtn:chipsView andFrame:delBtnFrame withIndex:index];
        index++;
        
        [self.amenitiesView addSubview:chipsView];
        adjMaxWidth -= (rectView.size.width + kGap);
        
    }
    
    //Add newamenity button.
    if(adjMaxWidth < (kAddNewAmenityBtnWidth + kGap)){
        xPos = kXPadding;
        yPos = yPos + kLabelHeight + kGap;
        adjMaxWidth = maxLabelWidth;
    }
    
    CGRect addAmenityBtnFrame = CGRectMake(xPos, yPos, kAddNewAmenityBtnWidth, kAddNewAmenityBtnHeight);
    [self addNewAmenityButton:addAmenityBtnFrame andCount:[amenitiesArray count]];
    
    //set row height
    if([amenitiesArray count] == 0)
    {
        self.rowHeightConstraint.constant = 40;
        [self layoutIfNeeded];
    }
    else
    {
    self.rowHeightConstraint.constant = (yPos + kBottomMargin) + kLabelHeight;
         [self layoutIfNeeded];
    }
}


-(void) addNewAmenityButton:(CGRect) frame andCount:(NSInteger) nAmenity{
    
    NSString *labelText;
    
    if(!nAmenity){
        frame.size.width += 40;
        labelText = kAddANewAmenity;
    }else{
        labelText = kAddAmenity;
    }
    
    
    UIView *addAmenityBtnView = [[UIView alloc] initWithFrame:frame];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5.0,
                                                               0.0,
                                                               frame.size.width-30,
                                                               frame.size.height)];

    label.text = labelText;
    
    [self.amenitiesView addSubview:addAmenityBtnView];
    addAmenityBtnView.layer.borderWidth = 1.0;
    addAmenityBtnView.layer.borderColor = kBtnBackColor.CGColor;
    [addAmenityBtnView addSubview:label];
    [Utility addShadowToView:addAmenityBtnView];
    [self addShadowOn: addAmenityBtnView];
    
    label.textColor = kBtnBackColor;
    label.font = [UIFont fontWithName:kFontName size:14.0];
    
    UILabel *btnLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width-20,
                                                                  0.0,
                                                                  20.0,
                                                                  25.0)];
    [addAmenityBtnView addSubview:btnLabel];
    btnLabel.text = @"+";
    [btnLabel setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:22]];
    btnLabel.textColor = kBtnBackColor;
    
    [self addTapGestureToAddAmenityBtn:addAmenityBtnView];
}


- (void)addTapGestureToAddAmenityBtn:(UIView *) view
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addAmenityTapped)];
    [view addGestureRecognizer:gesture];
}



- (void)addAmenityTapped
{
    AddAmenituView *view = [[AddAmenituView alloc]initWithTitle:kAddNewAmenityMessage andPlaceholder:kPlaceHolderText andBtnTitle:kAddBtnTitle];
    view.delegate = self;
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
}


- (void) addShadowOn:(UIView *) view{
    view.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.25f] CGColor];
    view.layer.shadowOffset = CGSizeMake(0, 1.0f);
    view.layer.shadowOpacity = 1.0f;
    view.layer.shadowRadius = 1.0f;
    view.layer.masksToBounds = NO;
    view.layer.cornerRadius = 3.0f;
}


- (IBAction)userPressedDelCategoryBtn:(UIButton *)sender {
    [self showAlert : kDelCategoryMsg onButton:sender andIndex:0];
}



- (void) addDeleteAmenityBtn:(UIView *) view andFrame:(CGRect) frame withIndex:(int)index{
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn addTarget:self
                  action:@selector(deleteChipsAmenity:)
        forControlEvents:UIControlEventTouchUpInside];
    
    deleteBtn.frame = frame;
    deleteBtn.tag = index + kDelAmenityBtnBaseTag;
    deleteBtn.titleLabel.font  = kFontAwesomeFont(16.0);
    [deleteBtn setTitle:kFontAwesomeText(kCrossBtnTitle) forState:UIControlStateNormal];
    [deleteBtn setTitleColor:kCrossBtnTextColor forState:UIControlStateNormal];
    
    [view addSubview:deleteBtn];
}


//Delete amenity from amenity category.
- (void) deleteChipsAmenity:(UIButton *) sender{
    int index = sender.tag % kDelAmenityBtnBaseTag;
    [self showAlert : kDelAmenityMsg onButton:sender andIndex:index];
}


//Handle delete amenity AlertController with user pressed delete button.
- (void)showAlert : (NSString *) alertMessage onButton:(UIButton *) sender andIndex : (int) index
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:kEmptyStr message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle: kAlertDelBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if(sender.tag == kDelCategoryBtnTag){
            [delegate userPressedDeleteCategoryOn:self];
        }else{
            [self.delegate userPressedDeleteAmenityon:self amenityIndex:index];
            
        }

    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:kAlertCancelBtbTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //No action on cancel.
    }]];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
}



- (IBAction)addAmenityBtnPressed:(UIButton *)sender {
}


#pragma mark - amenity delegate

- (void)didUserAddedAmenity:(NSString *)content onView:(AddAmenituView *)view
{
    [delegate userPressedAddNewAmenityOn:self addAmenity:content];
}



- (void)userTappedOutside
{
    [mainView removeFromSuperview];
}



-(void) onSubmitBtnClicked: (UIButton *) sender{
//    //Add logic to submit btn.
//    
//    if([textField.text length] >0){
//        [mainView removeFromSuperview];
//        [delegate userPressedAddNewAmenityOn:self addAmenity:textField.text];
//    }else{
//        [Utility showAlerWithMgs:kAddAmenityMsg];
//    }
//    
//    textField.text = kEmptyStr;
}

@end
