//
//  DropDownCell.h
//  PersonalWebsites
//
//  Created by vectoscalar on 17/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *menuItemLabel;


- (void)updateMenuItem:(NSString*)menuItem;

@end
