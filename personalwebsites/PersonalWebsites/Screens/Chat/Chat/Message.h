//
//  Message.h
//  Whatsapp
//
//  Created by Rafael Castro on 6/16/15.
//  Copyright (c) 2015 HummingBird. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MessageStatus)
{
    MessageStatusSending,
    MessageStatusSent,
    MessageStatusReceived,
    MessageStatusRead,
    MessageStatusFailed,
    MessageStatusOnline,
    MessageStatusOffline,
    MessageStatusUserLeft
};

typedef NS_ENUM(NSInteger, MessageSender)
{
    MessageSenderMyself,
    MessageSenderSomeone,
    MessageSenderBot
};

//
// This class is the message object itself
//
@interface Message : NSObject

@property (assign, nonatomic) MessageSender sender;
@property (assign, nonatomic) MessageStatus status;
@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *chat_id;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) CGFloat heigh;

+(Message *)messageFromDictionary:(NSDictionary *)dictionary;

//CordeData Mappers

@property (strong, nonatomic) NSString * imageUrl;
@property (strong, nonatomic) NSString *messageId;
//@property (strong, nonatomic) NSString *messageStatus;
@property (strong, nonatomic) NSString *messageText;
@property (assign, nonatomic) double  messageTime;
@property (strong,nonatomic) NSString * messageType;
@property (strong,nonatomic) NSString *reciver;
@property (strong,nonatomic) NSString *senderId; //sender = chatId
@property (strong,nonatomic) NSString *userType;




@end


