//
//  PropertyGalleryCell.m
//  PWPropertyImageGallery
//
//  Created by VectoScalar on 12/10/16.
//  Copyright © 2016 vs. All rights reserved.
//

#import "PropertyGalleryCell.h"

#define kDelImgWarnMsg      @"Are you sure, You want to delete this?"
#define kDelImgAlertTitle   @"Delete Gallery Image"


@interface PropertyGalleryCell()<UIGestureRecognizerDelegate, UITextFieldDelegate>
{
    NSString *captionTextBeforeEdit;
    BOOL needToShowSaveNavButton;
    BOOL isCreatedSaveRightNavItem;
}
@end


@implementation PropertyGalleryCell
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //Added icon on delete image button.
    self.deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 2);
    
    //Configure delete's button UI & add title.
    [Utility addFAUIOnButton:self.deleteBtn andFATitle:kTrashFA andColor:[UIColor redColor] andFont:kFAIconSize];
    
    //Set corner radious.
    self.layer.cornerRadius = 4.0;
    
    //Add delegate to image caption textfield.
    self.captionTextField.delegate = self;
    
    [self.captionTextField addTarget:self action:@selector(captionTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.cellImgView.userInteractionEnabled = YES;
    [self addTabGestureToImage];
}

- (void)addTabGestureToImage{
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapOnImageView)];
    
    [self.cellImgView addGestureRecognizer:gesture];
}



- (void)userTapOnImageView{
    [self.delegate showImageInScrollView:self];
}


//Delete uicollectionview cell button action.
- (IBAction)deleteImageBtnPressed:(UIButton *)sender {
    NSIndexPath *indexPath = [(UICollectionView *)self.superview indexPathForCell: self];
    
    //Delete image & cell with alert/confirmation.
    [self showAlert:kDelImgWarnMsg andIndex:indexPath];
}



//SHow warn alert before delete collectionview cell & gallery's image.
- (void)showAlert : (NSString *) alertMessage andIndex : (NSIndexPath *) indexPath
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:kDelImgAlertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle: kAlertDelBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //Delete cell after confirmation.
        [self deleteWithAnimtaionForIndex:indexPath];
        
        //If user editing image caption field, then hide save button before delete;
        if(needToShowSaveNavButton == YES){
            [self.delegate hideSaveCaptionButton];
        }
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:kAlertCancelBtbTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //No action on cancel.
    }]];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
}



//Show animation at delete of gallery image.
- (void)deleteWithAnimtaionForIndex:(NSIndexPath *) index
{
    CGRect frame = self.cellImgView.frame;
    
    CGFloat reduceToSize = 0.0;
    
    //Reduce frame to show animation.
    frame.origin.x += (frame.size.width - reduceToSize) / 2;
    frame.origin.y += (frame.size.height - reduceToSize) / 2;
    
    //Set frame size before delete.
    frame.size.height = reduceToSize;
    frame.size.width = reduceToSize;
    
    //Set animation frame size.
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         //Set reduce frame size to m=animation
                         self.cellImgView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         //Delete image from data & cell from uicollectionview.
                         [delegate deleteCollectionViewCellAt:index];
                         [self removeFromSuperview];
                     }
     ];
    
    [UIView commitAnimations];
}




-(void)captionTextFieldDidChange:(UITextField *) textField
{
    NSString *newString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (needToShowSaveNavButton == YES && [newString length] > [captionTextBeforeEdit length]) {
        [self.delegate createRightNavItem];
        needToShowSaveNavButton = NO;
        
    }else if(needToShowSaveNavButton == NO && [newString length] == [captionTextBeforeEdit length])
    {
        [self.delegate createRightNavItem];
        needToShowSaveNavButton = YES;
    }
}


#pragma -Mark UITextFieldDelegate <Methods>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    captionTextBeforeEdit = textField.text;
    needToShowSaveNavButton = YES;
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([captionTextBeforeEdit length] != [textField.text length]){
        [self.delegate updateCaptionLocalForImgCell:self];
        needToShowSaveNavButton = YES;
    }
    
    [self.captionTextField resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
@end
