//
//  ChatAccessor.m
//  GoFro
//
//  Created by VectoScalar on 09/06/16.
//  Copyright © 2016 BonaVita. All rights reserved.
//

#import "ChatAccessor.h"
//#import "RequestExecutor.h"

#define kMessageEntity @"GFMessage"
#define kBuyerEntity @"GFBuyer"
#define kChatEntity @"GFChat"

#define kContactName @"GoFro"
#define kBuyerId @"GF12"
#define kBuyerName @"BuyerName"


@implementation ChatAccessor

#pragma mark - Get Chats

+ (NSArray *)getAllChats
{
//    NSPredicate *predicate
//    = [NSPredicate predicateWithFormat:@"buyerId = %@",kBuyerId];
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kBuyerEntity];
//    fetchRequest.predicate = predicate;
//    
//    
//    
//    NSArray *array = [RequestExecutor executeRequestForEntity:kBuyerEntity predicate:predicate andDescriptor:nil];
//    
//    GFBuyer *buyer;
//    
//    
//    
//    if(array && [array count]>0)
//    {
//        buyer = [array objectAtIndex:0];
//    }
    
    NSArray *chatArray;// = [buyer.chats allObjects];
       
    
    return chatArray;
}


#pragma  mark - Get Unread Count

+ (int)getUnreadCountForChatId:(NSString *)chatId
{
    NSArray *chatArray = [ChatAccessor getMessagesForChatId:chatId];
    
    if(chatArray && [chatArray count]>0)
    {
        GFChat *chat = [chatArray objectAtIndex:0];
        
        int unreadCount = [chat.unreadMessages intValue];
        
        return unreadCount;
        
    }
    else
    {
        return 0;
    }
}



#pragma  mark - UpdateUnreadCount

+ (void)increaseUpdateCountOfUnreadMessagesForChatId:(NSString *)chatId
{
    NSArray *chatArray = [ChatAccessor getMessagesForChatId:chatId];
    
    if(chatArray && [chatArray count]>0)
    {
        GFChat *chat = [chatArray objectAtIndex:0];
        
        NSInteger unreadCount = [chat.unreadMessages integerValue];
        
        //inrease by 1
        unreadCount = unreadCount+1;
        
        [chat setUnreadMessages:[NSNumber numberWithInteger:unreadCount]];
        
       // [RequestExecutor saveContext];
        
    }
}


+ (void)resetUnreadCountForChatId:(NSString *)chatId
{
    NSArray *chatArray = [ChatAccessor getMessagesForChatId:chatId];
    
    if(chatArray && [chatArray count]>0)
    {
        GFChat *chat = [chatArray objectAtIndex:0];
        
        NSInteger unreadCount = 0;
        
        [chat setUnreadMessages:[NSNumber numberWithInteger:unreadCount]];
        
       // [RequestExecutor saveContext];
        
    }

}


#pragma mark - Get Messages

+ (NSArray *)getMessagesForChatId:(NSString *)chatId
{
//   
//    NSPredicate *predicate
//    = [NSPredicate predicateWithFormat:@"chatID = %@",chatId];
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kChatEntity];
//    fetchRequest.predicate = predicate;
//    
//

    NSArray *array;// = [RequestExecutor executeRequestForEntity:kChatEntity predicate:predicate andDescriptor:nil];


    return array;
}


#pragma mark - Save Message
+ (void)saveMessage:(Message*)message withChatId:(NSString*)chatId
{
   
//    GFMessage *gfMessage =[ChatAccessor isMessageExistWithId:message.messageId andChatId:chatId];
//    
//    if(gfMessage && gfMessage.messageId)
//    {
//
//        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"messageId==%@",message.messageId]; // If required to fetch specific message
    
//        GFMessage *msgToUpdate =  [[RequestExecutor executeRequestForEntity:kMessageEntity predicate:predicate andDescriptor:nil] lastObject];
        
//        [msgToUpdate setMessageStatus:[NSNumber numberWithInt:message.status]];
//        
//        
////        [RequestExecutor saveContext];
//    }
//    else
//    {
//        GFBuyer *buyer = [ChatAccessor getBuyer];
//        
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        GFMessage *cfMessage = [NSEntityDescription insertNewObjectForEntityForName:kMessageEntity inManagedObjectContext:appDelegate.managedObjectContext];
//        
//        cfMessage.imageUrl = message.imageUrl;
//        cfMessage.messageId = message.messageId;
//        cfMessage.messageStatus = [NSNumber numberWithInt:message.status];
//        cfMessage.messageText =  message.text;
//        cfMessage.messageTime = [NSNumber numberWithDouble:message.messageTime];
//        cfMessage.messageType = message.messageType;
//        cfMessage.receiver = message.reciver;
//        cfMessage.sender = message.senderId ; //equals to chatID
//        cfMessage.userType = [NSNumber numberWithInt:message.sender];
//        
//        
//        
//        GFChat *chat = [ChatAccessor getChatForChatId:chatId];
//        
//        [chat addMessagesObject:cfMessage];
//        
//        [buyer addChatsObject:chat];
//        
//        
//        [RequestExecutor saveContext];
//    }
    
}



+ (NSString *)getBuyerId
{
    
//    NSArray *buyerArray = [RequestExecutor executeRequestForEntity:kBuyerEntity predicate:nil andDescriptor:nil];
//    
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    GFBuyer *buyer;
//    
//    
//    if(buyerArray && [buyerArray count]>0)
//    {
//        buyer = [buyerArray objectAtIndex:0];
//    }
//    else
//    {
//        buyer = [NSEntityDescription insertNewObjectForEntityForName:kBuyerEntity inManagedObjectContext:appDelegate.managedObjectContext];
//        buyer.buyerId = kBuyerId;
//        buyer.buyerName = kBuyerName;
//        
//        [RequestExecutor saveContext];
//    }
//    
    return nil;//buyer.buyerId;
    
}


//+ (GFBuyer *)getBuyer
//{
//    
//    NSString *buyerId = [ChatAccessor getBuyerId];
//    
//    NSPredicate *predicate
//    = [NSPredicate predicateWithFormat:@"buyerId = %@",buyerId];
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kBuyerEntity];
//    fetchRequest.predicate = predicate;
//
//
//    NSArray *array = [RequestExecutor executeRequestForEntity:kBuyerEntity predicate:nil andDescriptor:nil];
//    
//    GFBuyer *buyer  ;
//
//    if(array && [array count]>0)
//    {
//        buyer = [array objectAtIndex:0];
//    }
//    
//    return buyer;
//}


+ (GFChat *)getChatForChatId:(NSString*)chatId
{

//    NSPredicate *predicate
//    = [NSPredicate predicateWithFormat:@"chatID = %@",chatId];
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kChatEntity];
//    fetchRequest.predicate = predicate;
//    
//    
//    NSArray *array = [RequestExecutor executeRequestForEntity:kChatEntity predicate:predicate andDescriptor:nil];
//    
//    GFChat *chat  ;
//    
//    if(array && [array count]>0)
//    {
//        chat = [array objectAtIndex:0];
//    }
//    else
//    {
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        GFChat *gfChat = [NSEntityDescription insertNewObjectForEntityForName:kChatEntity inManagedObjectContext:appDelegate.managedObjectContext];
//      
//        gfChat.chatID = chatId;
//        gfChat.contatct =kContactName;
//        
//        [RequestExecutor saveContext];
//        
//        chat = gfChat;
//    }
    

    return nil;// chat;
    
}



+ (GFMessage*)isMessageExistWithId:(NSString*)messageId andChatId:(NSString*)chatId
{
  
//    GFMessage *message;
//    
//    GFChat *chat = [ChatAccessor getChatForChatId:chatId];
//    
//    NSArray *messageArray = [NSArray arrayWithArray:[chat.messages allObjects]];
//    
//    
//    for(GFMessage *msg in messageArray)
//    {
//       if([msg.messageId isEqualToString:messageId])
//       {
//            message = msg;
//           [RequestExecutor saveContext];
//           break;
//       }
//       
//    }
    return nil;// message;
    
    
}

+ (void)updateStatus:(MessageStatus)status forMessageId:(NSString*)messageId
{
//    GFMessage *gfMessage =[ChatAccessor isMessageExistWithId:messageId andChatId:kChatId];
//    
//    if(gfMessage && gfMessage.messageId)
//    {
//        
//        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"messageId==%@",messageId]; // If required to fetch specific message
//        
//        GFMessage *msgToUpdate =  [[RequestExecutor executeRequestForEntity:kMessageEntity predicate:predicate andDescriptor:nil] lastObject];
//        
//        [msgToUpdate setMessageStatus:[NSNumber numberWithInt:status]];
//        
//        
//        [RequestExecutor saveContext];
//    }

}

#pragma mark - Save Message
+ (NSArray *)getSendingMessageArrayForChatId:(NSString*)chatId
{
    
//    NSPredicate *predicate
//    = [NSPredicate predicateWithFormat:@"chatID = %@",chatId];
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kChatEntity];
//    fetchRequest.predicate = predicate;
//    
//    
//    
//    NSArray *array = [RequestExecutor executeRequestForEntity:kChatEntity predicate:predicate andDescriptor:nil];
//    NSMutableArray *filteredMessageArray ;
//    filteredMessageArray = [[NSMutableArray alloc] init];
//    if([array count]>0)
//    {
//        GFChat *chat = [array objectAtIndex:0];
//        NSArray * messagesArray = [NSArray arrayWithArray:[chat.messages allObjects]];
//        
//        for(GFMessage *msg in messagesArray)
//        {
//            DebugLog(@"%@---",msg.messageStatus);
//            if([msg.messageStatus isEqualToNumber:[NSNumber numberWithInt:MessageStatusSending]])
//            {
//                [filteredMessageArray addObject:msg];
//            }
//        }
//        
//    }
//    
    return nil;// filteredMessageArray;
    
}


+ (GFMessage*)getLastMessageForChatId:(NSString *)chatId
{
//    GFMessage *lastMessage;
//    NSPredicate *predicate
//    = [NSPredicate predicateWithFormat:@"chatID = %@",chatId];
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kChatEntity];
//    fetchRequest.predicate = predicate;
//    
//    
//    NSArray *array = [RequestExecutor executeRequestForEntity:kChatEntity predicate:predicate andDescriptor:nil];
//    NSMutableArray *filteredMessageArray ;
//    filteredMessageArray = [[NSMutableArray alloc] init];
//    if([array count]>0)
//    {
//        GFChat *chat = [array objectAtIndex:0];
//        NSArray * messagesArray = [NSArray arrayWithArray:[chat.messages allObjects]];
//        
//        NSSortDescriptor *sortDescriptor;
//        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"messageTime"
//                                                     ascending:YES];
//        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//        NSArray *sortedArray = [messagesArray sortedArrayUsingDescriptors:sortDescriptors];
//        
//        
////        for(GFMessage *msg in sortedArray)
////        {
////            DebugLog(@"----MEssage=--%@---%@",msg.messageText,msg.messageTime);
////        }
//        
//       lastMessage = [sortedArray lastObject];
//    }
//    
    return nil;// lastMessage;
    
}


+ (void)deleteChatWithChatId:(NSString *)chatID
{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    GFChat *chat = [ChatAccessor getChatForChatId:chatID];
    
    NSArray *messageArray = [NSArray arrayWithArray:[chat.messages allObjects]];
    
    
    for(GFMessage *msg in messageArray)
    {
        [appDelegate.managedObjectContext deleteObject:msg];
    }

    [appDelegate.managedObjectContext deleteObject:chat];
    
    FT_SAVE_MOC(appDelegate.managedObjectContext);
}



@end
