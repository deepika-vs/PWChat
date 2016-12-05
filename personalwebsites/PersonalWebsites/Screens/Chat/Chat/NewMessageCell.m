//
//  NewMessageCell.m
//  GoFro
//
//  Created by VectoScalar on 06/06/16.
//  Copyright © 2016 BonaVita. All rights reserved.
//

#import "NewMessageCell.h"

#define kConstraintValue -6

@implementation NewMessageCell
@synthesize delegate;
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.receiveedMessageView.layer.cornerRadius = 2.0f;
    self.sentMessageView.layer.cornerRadius = 2.0f;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateMessageStatus:(BOOL)needToShowPic
{

    [self setBubble];
    if(_message.sender == MessageSenderMyself)
    {
        [self setStatusIcon];
        [self setFailedButton];
    }

}


- (void)setBubble
{
    if (_message.sender == MessageSenderMyself)
    {
        [self showSenderData];
        
    }
    else
    {
        [self showReceiverData];
    }
}


- (void)showReceiverData
{
    self.receivedBottom.constant = kConstraintValue;

    self.receivedMsgLabel.text = _message.text;
    
    
    NSString *str = [NSString stringWithFormat:@"%f",_message.messageTime];
    
    self.receivedMsgTimeLabel.text = [Utility getTimeInTwelveHourFormatWithTimeStamp:str];
    
    self.receiveedMessageView.backgroundColor = [UIColor whiteColor];
    self.receiveedMessageView.layer.borderColor = [UIColor colorWithRed:151.0/255.0f green:151.0/255.0f blue:151.0/255.0f alpha:0.3].CGColor;
    self.receiveedMessageView.layer.borderWidth = 0.5f;
    
    self.receiveedMessageView.hidden = NO;
    self.sentMessageView.hidden   = YES;

}


- (void)showSenderData
{
    self.sentMsgLabel.text = _message.text;
    
    NSString *messageTime = [NSString stringWithFormat:@"%f",_message.messageTime];
    self.sentMsgTime.text =[Utility getTimeInTwelveHourFormatWithTimeStamp:messageTime];
    self.sentMessageView.backgroundColor = [UIColor colorWithRed:226.0f/255.0 green:227.0f/255.0 blue:253.0f/255.0 alpha:1.0];
    self.sentMessageView.layer.borderColor = [UIColor colorWithRed:207.0/255.0f green:208.0/255.0f blue:232.0/255.0f alpha:1.0].CGColor;
    self.sentMessageView.layer.borderWidth = 0.8f;
    
    self.receiveedMessageView.hidden = YES;
    self.sentMessageView.hidden   = NO;
    
}


#pragma mark - Status Icon
-(void)setStatusIcon
{
    if (self.message.status == MessageStatusSending)
    {
              self.messageStatuslabel.text =@"Sending...";
        self.messageStatuslabel.textColor = kSendingColor;
    }
    else if (self.message.status == MessageStatusSent)
    {
        self.messageStatuslabel.text =@"Sent";
        self.messageStatuslabel.textColor = kSentColor;
    }
    else if (self.message.status == MessageStatusReceived)
    {
        self.messageStatuslabel.text = @"Delivered";
        self.messageStatuslabel.textColor = kDeliveredColor;
    }
    else if (self.message.status == MessageStatusRead)
    {
        self.messageStatuslabel.text = @"Delivered";
        self.messageStatuslabel.textColor = kDeliveredColor;
    }
    else if (self.message.status == MessageStatusFailed)
    {
        self.messageStatuslabel.text =@"";
    }
    
    self.statusImageView.hidden = _message.sender == MessageSenderSomeone;
}

#pragma mark - Failed Case

//
// This delta is how much TextView
// and Bubble should shit left
//
-(NSInteger)fail_delta
{
    return 60;
}
-(BOOL)isStatusFailedCase
{
    return self.message.status == MessageStatusFailed;
}
-(void)setFailedButton
{

    self.failButton.hidden = ![self isStatusFailedCase];
    [self.failButton setImage:[self imageNamed:@"status_failed"] forState:UIControlStateNormal];
}

#pragma mark - UIImage Helper

-(UIImage *)imageNamed:(NSString *)imageName
{
    return [UIImage imageNamed:imageName
                      inBundle:[NSBundle bundleForClass:[self class]]
 compatibleWithTraitCollection:nil];
}


- (IBAction)userPressedFailButton:(id)sender {
    
    NSLog(@"user Pressed Fail button");
    [delegate didUserTappedFailedMessage:self];
    
}
@end
