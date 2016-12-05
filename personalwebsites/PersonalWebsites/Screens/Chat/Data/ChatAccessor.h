//
//  ChatAccessor.h
//  GoFro
//
//  Created by VectoScalar on 09/06/16.
//  Copyright © 2016 BonaVita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "GFChat+CoreDataProperties.h"
#import "GFMessage+CoreDataProperties.h"
#import "GFBuyer+CoreDataProperties.h"
#import "Message.h"
#import "Chat.h"

@interface ChatAccessor : NSObject

+ (void)saveMessage:(Message*)message withChatId:(NSString*)chatId;


+ (NSArray *)getMessagesForChatId:(NSString *)chatId;


+ (NSArray *)getAllChats;
+ (GFChat *)getChatForChatId:(NSString*)chatId;


+ (void)increaseUpdateCountOfUnreadMessagesForChatId:(NSString *)chatId;
+ (void)resetUnreadCountForChatId:(NSString *)chatId;
+ (int)getUnreadCountForChatId:(NSString *)chatId;
+ (void)updateStatus:(MessageStatus)status forMessageId:(NSString*)messageId;
+ (NSArray *)getSendingMessageArrayForChatId:(NSString*)chatId;
+ (GFMessage*)getLastMessageForChatId:(NSString *)chatId;
+ (void)deleteChatWithChatId:(NSString*)chatID;
@end
