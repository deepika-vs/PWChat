//
//  PropertyGalleryCell.h
//  PWPropertyImageGallery
//
//  Created by VectoScalar on 12/10/16.
//  Copyright © 2016 vs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWTextField.h"

#define kUnselectedIcon @"uncheckBoxIcon"
#define kSelectedIcon   @"checkBoxIcon"

@class PropertyGalleryCell;

@protocol PropertyGalleryCellDelegate <NSObject>
- (void)deleteCollectionViewCellAt:(NSIndexPath *) indexPath;
- (void)showImageInScrollView:(PropertyGalleryCell *)cell;
- (void)createRightNavItem;
- (void)showSaveCaptionButton;
- (void)hideSaveCaptionButton;
- (void)updateCaptionLocalForImgCell:(PropertyGalleryCell *)cell;
@end

@interface PropertyGalleryCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImgView;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (strong, readwrite) NSIndexPath *currentCellIndexPath;

@property (assign, nonatomic) NSInteger rowIndex;


@property (weak, nonatomic) IBOutlet PWTextField *captionTextField;

@property (assign, nonatomic) id <PropertyGalleryCellDelegate> delegate;

- (IBAction)deleteImageBtnPressed:(UIButton *)sender;

- (void)addTabGestureToImage;

@end
