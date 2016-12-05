//
//  LocalStorage.m
//  Whatsapp
//
//  Created by Rafael Castro on 7/24/15.
//  Copyright (c) 2015 HummingBird. All rights reserved.
//

#import "LocalStorage.h"
#import "ChatAccessor.h"

@interface LocalStorage ()
@property (strong, nonatomic) NSMutableDictionary *mapChatToMessages;
@end


@implementation LocalStorage

+(id)sharedInstance
{
    static LocalStorage *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(id)init
{
    self = [super init];
    if (self)
    {
        self.mapChatToMessages = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)storeMessage:(Message *)message
{
    [self storeMessages:@[message]];
    
    [LocalStorage saveMessageForChatID:kChatId andMessage:message];
}

-(void)storeMessages:(NSArray *)messages
{
    if (messages.count == 0) return;
    
    NSString *chat_id = kChatId;
    NSMutableArray *array = (NSMutableArray *)[self queryMessagesForChatID:chat_id];
    if (array)
    {
        [array addObjectsFromArray:messages];
    }
    else
    {
        array = [[NSMutableArray alloc] initWithArray:messages];
    }
    [self.mapChatToMessages setValue:array forKey:chat_id];
}
-(NSArray *)queryMessagesForChatID:(NSString *)chat_id
{
    return [self.mapChatToMessages valueForKey:chat_id];
}


+ (NSArray *)getChatForChatId:(NSString*)chatId
{
    
    NSArray *messageArray = [ChatAccessor getMessagesForChatId:chatId];
    
    GFChat *gfChat = [messageArray objectAtIndex:0];
    
    NSArray  *array = [NSArray arrayWithArray:[gfChat.messages allObjects]];
    
    for(GFMessage *msg in array)
    {
        NSLog(@"Message from Coredata----%@---",msg.messageText);
        
    }
    
    return messageArray;
    
}

+ (void)saveMessageForChatID:(NSString*)chatId andMessage:(Message*)message
{
    if(message.messageId)
    [ChatAccessor saveMessage:message withChatId:chatId];
}



@end
