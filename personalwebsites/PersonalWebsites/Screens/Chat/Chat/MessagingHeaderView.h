//
//  MessagingHeaderView.h
//  Whatsapp
//
//  Created by VectoScalar on 5/13/16.
//  Copyright © 2016 HummingBird. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagingHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *typingStatusLabel;



- (void)configureUI;

- (void)updateLabelsWithName:(NSString*)name andStatus:(NSString*)typingStatus;





@end
