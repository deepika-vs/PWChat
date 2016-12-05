//
//  MessagingHeaderView.m
//  Whatsapp
//
//  Created by VectoScalar on 5/13/16.
//  Copyright © 2016 HummingBird. All rights reserved.
//

#import "MessagingHeaderView.h"

@implementation MessagingHeaderView

- (void)configureUI{
    
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
    self.profileImageView.layer.masksToBounds = YES;
}

- (void)updateLabelsWithName:(NSString *)name andStatus:(NSString *)typingStatus
{
    self.userNameLabel.text = name;
    self.typingStatusLabel.text = typingStatus;
}

@end
