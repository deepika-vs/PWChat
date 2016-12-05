//
//  MenuSliderCell.h
//  SportInfo
//
//  Created by vectoscalar on 24/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuSliderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *menuTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *menuIcon;

- (void)updateMenuWithTitle:(NSString *)title withImageName:(NSString*)imgName;

@end
