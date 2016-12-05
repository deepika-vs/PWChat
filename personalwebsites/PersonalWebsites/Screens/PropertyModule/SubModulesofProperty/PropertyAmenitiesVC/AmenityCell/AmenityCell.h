//
//  AmenityCell.h
//  PersonalWebsites
//
//  Created by VectoScalar on 22/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAmenituView.h"

#define kAddBtnTitle            @"Add Amenity"
#define kAddNewAmenity          @"Add new Amenity"

@class AmenityCell;

@protocol AmenityCellDelegate <NSObject>

-(void)userPressedDeleteAmenityon:(AmenityCell *)cell amenityIndex:(int) amenityIndex;
-(void)userPressedDeleteCategoryOn:(AmenityCell *)cell;
-(void)userPressedAddNewAmenityOn:(AmenityCell *)cell addAmenity: (NSString *) amenity;

@end


@interface AmenityCell : UITableViewCell<AddAmenityViewDelegate>
{
    UIView *mainView;
    UITextField *textField;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rowHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *contentsView;

@property (weak, nonatomic) IBOutlet UIView *amenitiesView;

@property (weak, nonatomic) IBOutlet UILabel *amenityCategoryLbl;

@property (weak, nonatomic) IBOutlet UIButton *deleteCateBtn;

@property (assign, nonatomic) id <AmenityCellDelegate> delegate;

- (void)addAmenitiesToCell:(NSArray *) amenitiesArray withCellWidth:(CGFloat)cellWidth ;

- (IBAction)userPressedDelCategoryBtn:(UIButton *)sender;
- (void)addTapGestureToAddAmenityBtn:(UIView *) view;

@end
