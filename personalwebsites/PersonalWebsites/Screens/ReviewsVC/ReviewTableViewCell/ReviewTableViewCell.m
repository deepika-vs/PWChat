//
//  ReviewTableViewCell.m
//  PersonalWebsites
//
//  Created by VectoScalar on 19/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "ReviewTableViewCell.h"

#define kDeleteAlertTitle         @"Delete Review"
#define kDeleteAlertMsg           @"Do you want to delete the review?"


@implementation ReviewTableViewCell

//Synthesize ReviewTableViewCellDeledate property.
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self layoutIfNeeded];
    
    //Add button's font-awesome title and background color.
    [Utility addFAUIOnButton:self.deleteButton andFATitle:kTrashFA andColor:[UIColor redColor] andFont:kFAIconSize];
    
    [Utility addFAUIOnButton:self.editButton andFATitle:kEditFAIcon andColor:kNavColor andFont:kFAIconSize];
    
    //Create image view as circular.
    self.usrImgView.layer.cornerRadius = self.usrImgView.frame.size.width / 2.0;// 28;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [Utility addShadowToView:self.contentsView];
    // Configure the view for the selected state
}


- (void) setDataToCellFields:(ReviewWrapper *) wrapper{
    
    //Fill data to review cell to display in tableview.
    self.uNameLbl.text = wrapper.customerName;
    
    self.addressLbl.text = wrapper.address;
    
    self.reviewHeadingLbl.text = wrapper.heading;
    
    UIImage *imgWithNewSize = [Utility resizeImgWithImage:wrapper.customerProfileImg scaledToSize:CGSizeMake(58, 58)];
    
    self.usrImgView.image = imgWithNewSize;
    
    self.contentsLbl.text = wrapper.content;
    
    self.propertyNameLbl.text = wrapper.propertyName;
}


- (IBAction)userPressedDeleteBtn:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:kDeleteAlertTitle message:kDeleteAlertMsg preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle: kAlertDelBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //Delete with confirmation.
        [delegate userPressedDeleteReviewOnCell:self];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:kAlertCancelBtbTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //No action on cancel.
    }]];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
}



- (IBAction)userPressedEditBtn:(UIButton *)sender {
    //User pressed edit review button on cell.
    [delegate userPressedEditReviewOnCell:self];
}

@end
