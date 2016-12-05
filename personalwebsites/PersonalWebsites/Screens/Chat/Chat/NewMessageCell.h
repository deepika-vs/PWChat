//
//  NewMessageCell.h
//  GoFro
//
//  Created by VectoScalar on 06/06/16.
//  Copyright © 2016 BonaVita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@class NewMessageCell;

@protocol MessageCellDelegate <NSObject>

- (void)didUserTappedFailedMessage:(UITableViewCell*)cell;

@end

@interface NewMessageCell : UITableViewCell

//Recevied Message Outlets

@property (weak, nonatomic) IBOutlet UIView *receiveedMessageView;

@property (weak, nonatomic) IBOutlet UILabel *receivedMsgLabel;


@property (weak, nonatomic) IBOutlet UILabel *receivedMsgTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageStatuslabel;

//Sent Message Outlets

@property (weak, nonatomic) IBOutlet UIView *sentMessageView;
@property (weak, nonatomic) IBOutlet UILabel *sentMsgLabel;

@property (weak, nonatomic) IBOutlet UILabel *sentMsgTime;


@property (weak, nonatomic) IBOutlet UIButton *failButton;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;


@property (strong, nonatomic) Message *message;
@property (strong, nonatomic) UIButton *resendButton;

-(void)updateMessageStatus:(BOOL)needToShowPic;


- (IBAction)userPressedFailButton:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sentViewBottom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *receivedBottom;

@property (assign,nonatomic) id<MessageCellDelegate> delegate;


@end
