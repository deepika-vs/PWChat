//
//  LocalStorage.h
//  Whatsapp
//
//  Created by Rafael Castro on 7/24/15.
//  Copyright (c) 2015 HummingBird. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
#import "Chat.h"

// This class is responsable to store messages
// For now, it stores in memory only
//
@interface LocalStorage : NSObject
+(id)sharedInstance;

-(void)storeMessage:(Message *)message;
-(NSArray *)queryMessagesForChatID:(NSString *)chat_id;



+ (void)saveMessageForChatID:(NSString*)chatId andMessage:(Message*)message;
+ (NSArray *)getChatForChatId:(NSString*)chatId;



@property (assign,nonatomic) int unreadCount;
@end
