//
//  ChatUICell.h
//  GoFro
//
//  Created by Rahul Mishra on 03/08/16.
//  Copyright © 2016 BonaVita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@class ChatUICell;

@protocol ChatUICellDelegate <NSObject>

- (void)didUserTappedFailedMessage:(UITableViewCell*)cell;

@end

@interface ChatUICell : UITableViewCell

//Cell Height Constraint
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellHeightConstraint;

//Recevied Message Outlets

@property (weak, nonatomic) IBOutlet  UIView *receiveedMessageView;
@property (weak, nonatomic) IBOutlet UILabel *receivedMsgLabel;
@property (weak, nonatomic) IBOutlet UILabel *receivedMsgTimeLabel;
@property (weak,nonatomic)IBOutlet UIImageView *receiverImageView;


//Sent Message Outlets

@property (weak, nonatomic)IBOutlet  UIView *sentMessageView;
@property (weak, nonatomic)IBOutlet  UILabel *sentMsgLabel;
@property (weak, nonatomic)IBOutlet  UILabel *sentMsgTime;
@property (weak, nonatomic)IBOutlet  UIButton *failButton;
@property (weak, nonatomic)IBOutlet  UILabel *messageStatuslabel;
@property (weak,nonatomic)IBOutlet UIImageView *senderImageView;

@property (strong, nonatomic) Message *message;


- (void)updateChatUIWithUserImageStatus:(BOOL)needToShowImage;
+ (CGFloat)getHeightForMessage:(Message*)message;
@property (assign,nonatomic) id<ChatUICellDelegate> delegate;

@end
