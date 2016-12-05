//
//  ChatUICell.m
//  GoFro
//
//  Created by Rahul Mishra on 03/08/16.
//  Copyright © 2016 BonaVita. All rights reserved.
//

#import "ChatUICell.h"

#define kXPadding 8
#define kYPadding 2
#define kImageSize 38

#define kChatTimeGap 4

#define kBorderWidth 0.9f
#define kBorderRadius 2.0f

//Border Colors
#define kSentBorderColor [UIColor colorWithRed:207.0/255.0f green:208.0/255.0f blue:232.0/255.0f alpha:1.0].CGColor
#define kReceivedBorderColor [UIColor colorWithRed:151.0/255.0f green:151.0/255.0f blue:151.0/255.0f alpha:0.3].CGColor

//Background Colors
#define kSentMessageViewBGColor [UIColor colorWithRed:226.0f/255.0 green:227.0f/255.0 blue:253.0f/255.0 alpha:1.0]

#define kUserImage @"defaultUserPic"
#define kChatClientImage @"userImg.png"
#define kSampleTimeText @"59:59 PM"

//Fonts

#define kChatFont  kRobotoRegular(kFontSize14)
#define kTimeFont  kRobotoRegular(kFontSize10)

#define kTimeColor [UIColor lightGrayColor]

#define kFailedButtonTitle @"Failed"
#define kFailedButtonImage @"status_failed"


@implementation ChatUICell
@synthesize delegate;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateChatUIWithUserImageStatus:(BOOL)needToShowImage
{
    [self setBubbleWithImageStatus:needToShowImage];
    if(_message.sender == MessageSenderMyself)
    {
        [self setStatusIcon];
        [self setFailedButton];
    }

}

- (void)setBubbleWithImageStatus:(BOOL)imageStatus
{
    if (_message.sender == MessageSenderMyself)
    {
        [self configureUIForSenderWithImageStatus:imageStatus];
        
    }
    else
    {
        [self configureUIForReceiverWithStatus:imageStatus];
    }
}



#pragma mark - Status Icon
-(void)setStatusIcon
{
    if (self.message.status == MessageStatusSending)
    {
        self.messageStatuslabel.text =@"Sending";
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


- (void)userPressedFailButton{
    
    DebugLog(@"user Pressed Fail button");
    [delegate didUserTappedFailedMessage:self];
    
}


#pragma mark - UI For Receiver Method
- (void)configureUIForReceiverWithStatus:(BOOL)imageStatus
{
    self.receiveedMessageView.hidden = false;
    self.receiverImageView.hidden = false;
    
    self.sentMessageView.hidden = true;
    self.senderImageView.hidden = true;
       
    //**Minimum Size of Chat Box - To hold time
    CGSize minBoxSize = [Utility getTheSizeForText:kSampleTimeText andFont:kTimeFont toFitInWidth:kScreenSize.width];
    minBoxSize.width += 2*kXPadding;
    CGFloat cellHeight;
    
    CGFloat availableWidthForChat = kScreenSize.width - 6*kXPadding-2*kImageSize;
    
    
    //Make Receiver UI
    
   //******Receiver Image******//
   if(imageStatus)
   {
     
       self.receiverImageView.frame = CGRectMake(kXPadding, kXPadding, kImageSize, kImageSize);
       
        self.receiverImageView.image = [UIImage imageNamed:kChatClientImage];
        self.receiverImageView.contentMode = UIViewContentModeScaleAspectFit;
     
        self.receiverImageView.hidden = NO;
       
   }
   else
   {
       self.receiverImageView.hidden = YES;
   }
    
    
    //****Receiver Chat Box******//
    
    //Get the size of text
    
    CGSize chatTextSize = [Utility getTheSizeForText:_message.text andFont:kChatFont toFitInWidth:availableWidthForChat];
    chatTextSize.width += 2*kXPadding;
    
    //Set Minimum Width if Text size is less than minimum width
    
    if(chatTextSize.width < minBoxSize.width)
    {
        chatTextSize.width = minBoxSize.width;
    }
    

    
    CGFloat xPosForReceiver = 2*kXPadding+kImageSize;
    
   
   self.receiveedMessageView.frame = CGRectMake(xPosForReceiver, kYPadding, chatTextSize.width, chatTextSize.height+minBoxSize.height+3*kChatTimeGap);

    
    self.receiveedMessageView.backgroundColor = [UIColor whiteColor];
    self.receiveedMessageView.tag = 10001;
    self.receiveedMessageView.layer.borderWidth = kBorderWidth;
    self.receiveedMessageView.layer.borderColor = kReceivedBorderColor;
    self.receiveedMessageView.layer.cornerRadius  = kBorderRadius;
    
    
    
    //*** Fill the content with chat text
    self.receivedMsgLabel.frame =CGRectMake(kXPadding, kChatTimeGap,self.receiveedMessageView.frame.size.width-2*kXPadding, chatTextSize.height);
    self.receivedMsgLabel.text = _message.text;
    self.receivedMsgLabel.font = kChatFont;
    
    
    
    //***Make time Label****//
   // CGFloat timeLabelXPos = self.receiveedMessageView.frame.size.width-kXPadding-(minBoxSize.width-kXPadding);
    CGFloat timeLabelXPos = kXPadding;
        self.receivedMsgTimeLabel.frame = CGRectMake(timeLabelXPos, self.receivedMsgLabel.frame.size.height+self.receivedMsgLabel.frame.origin.y+kChatTimeGap, minBoxSize.width-kXPadding, minBoxSize.height);
    
    
    NSString *str = [NSString stringWithFormat:@"%f",_message.messageTime];
    self.receivedMsgTimeLabel.text = [Utility getTimeInTwelveHourFormatWithTimeStamp:str];
    self.receivedMsgTimeLabel.font = kTimeFont;
    self.receivedMsgTimeLabel.textColor = kTimeColor;
    self.receivedMsgLabel.numberOfLines = 999;
    self.receivedMsgTimeLabel.textAlignment = NSTextAlignmentLeft;
    cellHeight = kYPadding+self.receiveedMessageView.frame.size.height+kYPadding;
   // self.cellHeightConstraint.constant = cellHeight;
    
}



#pragma mark - Sender UI Method
- (void)configureUIForSenderWithImageStatus:(BOOL)imageStatus
{

    self.receiveedMessageView.hidden = true;
    self.receiverImageView.hidden = true;
    
    self.sentMessageView.hidden = false;
    self.senderImageView.hidden = false;
    
    
    //**Minimum Size of Chat Box - To hold time
    CGSize minBoxSize = [Utility getTheSizeForText:kSampleTimeText andFont:kTimeFont toFitInWidth:kScreenSize.width];
    minBoxSize.width += 2*kXPadding;
    CGFloat cellHeight;
    
    CGFloat availableWidthForChat = kScreenSize.width - 6*kXPadding-2 *kImageSize;
    
    //Calculate X Position for userImage
    
     CGFloat userImageXPos = kScreenSize.width - kXPadding-kImageSize;
    
    //Make Receiver UI
    
    //******Receiver Image******//
    
    
    if(imageStatus)
    {
       self.senderImageView.frame = CGRectMake(userImageXPos, kXPadding, kImageSize, kImageSize);
        self.senderImageView.image = [UIImage imageNamed:kUserImage];
        self.senderImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.senderImageView.hidden = NO;
    }
    else
    {
        self.senderImageView.hidden = YES;
    }
    
    //****Receiver Chat Box******//
    
    //Get the size of text
    
    CGSize chatTextSize = [Utility getTheSizeForText:_message.text andFont:kChatFont toFitInWidth:availableWidthForChat];
    chatTextSize.width += 2*kXPadding;
    
    //Set Minimum Width if Text size is less than minimum width
    
    if(chatTextSize.width < minBoxSize.width)
    {
        chatTextSize.width = minBoxSize.width;
    }
    
    
    
    CGFloat xPosForReceiver = userImageXPos-kXPadding-chatTextSize.width;
    

    self.sentMessageView.frame = CGRectMake(xPosForReceiver, kYPadding, chatTextSize.width, chatTextSize.height+minBoxSize.height+3*kChatTimeGap);
    
    self.sentMessageView.backgroundColor = kSentMessageViewBGColor;
    self.sentMessageView.tag = 10001;
    self.sentMessageView.layer.borderWidth = kBorderWidth;
    self.sentMessageView.layer.borderColor = kSentBorderColor;
    self.sentMessageView.layer.cornerRadius  = kBorderRadius;
    
    
    
    //*** Fill the content with chat text
  
    self.sentMsgLabel.frame =CGRectMake(kXPadding, kChatTimeGap,self.sentMessageView.frame.size.width-2*kXPadding, chatTextSize.height);
    
    self.sentMsgLabel.text = _message.text;
    self.sentMsgLabel.font = kChatFont;
   // self.sentMsgLabel.textAlignment = NSTextAlignmentRight;
    
   
    //***Make time Label****//
    CGFloat timeLabelXPos = self.sentMessageView.frame.size.width-kXPadding-(minBoxSize.width-kXPadding);
    
    self.sentMsgTime.frame = CGRectMake(timeLabelXPos,self.sentMsgLabel.frame.size.height+self.sentMsgLabel.frame.origin.y ,(minBoxSize.width-kXPadding), minBoxSize.height);
    
    //****MAKE MESSAGE STATUS LABEL****//
    
   
    self.messageStatuslabel.frame = CGRectMake(kXPadding,self.sentMsgTime.frame.size.height+self.sentMsgTime.frame.origin.y,self.sentMessageView.frame.size.width-2*kXPadding,minBoxSize.height);
    
    self.messageStatuslabel.font = kTimeFont;
    self.messageStatuslabel.textAlignment = NSTextAlignmentRight;
 
    //***Failed Button Construction***//
    CGFloat failedButtonWidth = minBoxSize.width-kXPadding;
    
   self.failButton.frame = CGRectMake(self.sentMessageView.frame.size.width-failedButtonWidth-kXPadding,self.sentMsgTime.frame.size.height+self.sentMsgTime.frame.origin.y-2,failedButtonWidth,19);
    
    [self.failButton setTitle:kFailedButtonTitle forState:UIControlStateNormal];
    [self.failButton setImage:[UIImage imageNamed:kFailedButtonImage] forState:UIControlStateNormal];
    [self.failButton setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:25.0f/355.0f blue:69.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    self.failButton.titleLabel.font = kRobotoRegular(kFontSize10);
    self.failButton.imageEdgeInsets = UIEdgeInsetsMake(3, 7, 3, 1);
    [self.failButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 11, 0, 0)];
    self.failButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.failButton addTarget:self action:@selector(userPressedFailButton) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    NSString *str = [NSString stringWithFormat:@"%f",_message.messageTime];
    self.sentMsgTime.text = [Utility getTimeInTwelveHourFormatWithTimeStamp:str];
    self.sentMsgTime.font = kTimeFont;
    self.sentMsgTime.textColor = kTimeColor;
    self.sentMsgLabel.numberOfLines = 999;
    
    
    
    cellHeight = self.messageStatuslabel.frame.size.height+self.messageStatuslabel.frame.origin.y+kYPadding;
    
    //Change the MessageViewFRame
    
    CGRect frame = self.sentMessageView.frame;
    frame.size.height = self.messageStatuslabel.frame.size.height+self.messageStatuslabel.frame.origin.y+kYPadding;
    self.sentMessageView.frame = frame;
    
   // self.cellHeightConstraint.constant = cellHeight+kChatTimeGap;

}


+ (CGFloat)getHeightForMessage:(Message*)message
{
    CGFloat cellHeight;

    CGFloat availableWidthForChat = kScreenSize.width - 6*kXPadding-2 *kImageSize;
    
    CGSize chatTextSize = [Utility getTheSizeForText:message.text andFont:kChatFont toFitInWidth:availableWidthForChat];
    
    CGSize timeSize = [Utility getTheSizeForText:kSampleTimeText andFont:kTimeFont toFitInWidth:availableWidthForChat];
    
    if(message.sender != MessageSenderMyself)
    {
        cellHeight = chatTextSize.height + timeSize.height + 4*kChatTimeGap;
    }
    else
    {
        cellHeight = chatTextSize.height +2*timeSize.height+3*kChatTimeGap;
    }
    
    return cellHeight;
}

@end
