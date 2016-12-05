

#import "ChatManager.h"
#import "LocalStorage.h"
#import "MessageController.h"
#import "Chat.h"
//#import "DDLog.h"
//#import "DDTTYLogger.h"
//#import "XMPPRoomMemoryStorage.h"
//#import "XMPPRoom.h"
//#import "XMPPMessage+XEP_0085.h"
#import "ChatAccessor.h"
//#import "XMppp"

#define kChatLogFile @"chatLog.txt"
#define kChatID @"pre-prod-chat1.bonavitatech.com"

@interface ChatManager()
 @property (strong, nonatomic) NSMutableArray *messages_to_send;

//- (void)setupStream;
//- (void)goOnline;
//- (void)goOffline;

@end



@implementation ChatManager
@synthesize messageDelegate;


#pragma mark- init Methods

+(id)sharedChatManager
{
    static ChatManager *sharedInstance = nil;
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
        self.messages_to_send = [[NSMutableArray alloc] init];
//        _gateWay = [[GateWay alloc] init];
//        _gateWay.delegate = self;
        
    }
    return self;

}




- (void)makeTockenAPI{
    
//    self.apiManager.delegate = nil;
//    self.apiManager = nil;
//    
//    self.apiManager = [[APIManager alloc] init];
//    self.apiManager.delegate = self;
//    
//    
//    NSMutableDictionary *headerDict = [[NSMutableDictionary alloc]init];
//    [headerDict setObject:kLoginHeaderValue forKey:kLoginHeaderKey];
//    
//    
//    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
//    [paramDict setObject:headerDict forKey:kHeaderKey];
//    
//    [self.apiManager getServerDataWithParam:paramDict apiMethodType:kAPIMethodTypeGET andMapperClass:[ChatTockenMapper class]];
//    
//    [self writeOnFileLog:@"----Making api/user/gat API to get tocken----"];
    
    
}


- (void)connect{
    
    
//    [self writeOnFileLog:@"------connect----"];
//    
//    NSString *chatTocken = [[DataManager sharedDataManager] chatTocken];
//    
//    if([Utility isEmptyOrNilForString:chatTocken]){
//        
//        [self makeTockenAPI];
//    }
//    else{
//        
//        [_gateWay connect];
//    }
    
    //Need to fetch tocken on every connection

    
//    if([_gateWay isConnected]){
//        
//        [self makeTockenAPI];
//    }
    
}


- (void)disconnect{
    
   // [_gateWay disconnect];
}


- (void)disconnectWithoutPrompting
{
   // [_gateWay disconnectWithoutPrompting];
}



- (BOOL)isChatConnected
{
    BOOL status;// = [_gateWay isChatServerRunning];
    
    return status;
}


-(void)loadOldMessages
{
    GFChat *chat = [ChatAccessor getChatForChatId:kChatId];
    NSArray *array = [chat.messages allObjects];
    
    NSMutableArray *messageArray = [[NSMutableArray alloc] init];
    
    
    if (self.messageDelegate)
    {
       for(GFMessage *coreDataMessage in array)
       {
           Message *message = [[Message alloc] init];
           
           message.text = coreDataMessage.messageText;
           message.chat_id = chat.chatID;
           message.identifier = coreDataMessage.messageId;
           message.sender = [coreDataMessage.userType intValue];
           message.messageId = coreDataMessage.messageId;
           message.status = [coreDataMessage.messageStatus intValue];
           message.messageTime = [coreDataMessage.messageTime doubleValue];
      
          [messageArray addObject:message];
    
       }
        
    
    }
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"messageId"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [messageArray sortedArrayUsingDescriptors:sortDescriptors];
    
    
    [self.messageDelegate chatManagerFinishLoadingOlderMessage:sortedArray];
    NSArray *unreadMessages = [self queryUnreadMessagesInArray:sortedArray];
    [self updateStatusToReadInArray:unreadMessages];
}


-(void)updateStatusToReadInArray:(NSArray *)unreadMessages
{
    NSMutableArray *read_ids = [[NSMutableArray alloc] init];
    for (Message *message in unreadMessages)
    {
        message.status = MessageStatusRead;
        [read_ids addObject:message.identifier];
    }
    self.chat.numberOfUnreadMessages = 0;
    [self sendReadStatusToMessages:read_ids];
}


-(NSArray *)queryUnreadMessagesInArray:(NSArray *)array
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.status == %d", MessageStatusReceived];
    return [array filteredArrayUsingPredicate:predicate];
}

-(void)news
{
    
}

-(void)dismiss
{
    self.messageDelegate = nil;
}


- (void)writeOnFileLog:(NSString *)logText{

    
//    logText = [logText stringByAppendingString:@"\n"];
//    
//    //Get the file path
//    NSString *documentsDirectory = [[DataManager sharedDataManager] documentDirectoryPath];
//    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:kChatLogFile];
//    
//    //create file if it doesn't exist
//    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
//        
//        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
//    }
//    
//    NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
//    [file seekToEndOfFile];
//    [file writeData:[logText dataUsingEncoding:NSUTF8StringEncoding]];
//    [file closeFile];
    
}


- (NSString *)getChatLogs{
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:kChatLogFile];
  
    NSString *content = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    if([Utility isEmptyOrNilForString:content]){
        
        return @"No Logs Yet";
    }
    return content;
}


//-(void)fakeMessageUpdate:(Message *)message
//{
//    [self performSelector:@selector(updateMessageStatus:) withObject:message afterDelay:2.0];
//}
//
//
//-(void)updateMessageStatus:(Message *)message
//{
//    if (message.status == MessageStatusSending)
//        message.status = MessageStatusFailed;
//    else if (message.status == MessageStatusFailed)
//        message.status = MessageStatusSent;
//    else if (message.status == MessageStatusSent)
//        message.status = MessageStatusReceived;
//    else if (message.status == MessageStatusReceived)
//        message.status = MessageStatusRead;
//    
//    if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(chatManagerDidUpdateStatusForMessage:)])
//    {
//        [self.messageDelegate chatManagerDidUpdateStatusForMessage:message.messageId];
//    }
//    
//    //
//    // Remove this when connect to your server
//    // fake update message
//    //
//    if (message.status != MessageStatusRead)
//        [self fakeMessageUpdate:message];
//}


#pragma mark - Exchange data with API

-(void)sendMessage:(Message *)message
{
    //
    // Add here your code to send message to your server
    // When you receive the response, you should update message status
    // Now I'm just faking update message
    //
    
    
    if(message && message.messageId)
    {
        [[LocalStorage sharedInstance] storeMessage:message];
       // [self fakeMessageUpdate:message];

        //[_gateWay sendMessage:message];
    }
    
}



-(void)sendReadStatusToMessages:(NSArray *)message_ids
{
   if ([message_ids count] == 0) return;
    //TODO
}
-(void)sendReceivedStatusToMessages:(NSArray *)message_ids
{
    if ([message_ids count] == 0) return;
    //TODO
}



- (void)updateTypingStatus:(BOOL)isTyping forChat:(Chat *)chat{
    
    if(isTyping){
        
        DebugLog(@"Typing .....");
    }
    else{
        
        DebugLog(@"Typing Stopped...");
    }
    
}


- (void)shareMedia:(Media *)media{
    
    
    
}

- (void)stopTypingStatus{
    
    [self.messageDelegate chatManagerDidReceiveTyping:NO];
}

#pragma mark- APIManager Delegate - Method


//- (void)manager:(APIManager *)manager didFailedForMapper:(APIMapper *)mapper{
//    
//    [self writeOnFileLog:@"---didFailedForMapper----"];
//    [self.messageDelegate chatManagetDidFailedToGetToken];
//    
//}
//
//
//- (void)manager:(APIManager *)manager didFinishedForMapper:(APIMapper *)mapper{
//    
//    [self writeOnFileLog:@"---didFailedForMapper----"];
//    
//    if(mapper && [mapper isKindOfClass:[ChatTockenMapper class]]){
//        
//        ChatTockenMapper *chatMapper = (ChatTockenMapper *)mapper;
//        [[DataManager sharedDataManager] saveChatTocken:chatMapper.result];
//        
//        [self writeOnFileLog:[NSString stringWithFormat:@"Received Tocken = %@", chatMapper.result]];
//        [_gateWay connect];
//    }
//    
//}
//



#pragma mark- GateWayDelegate
//
//- (void)gateWay:(GateWay *)gateWay didReceiveMessage:(Message *)message{
//    
//
//    if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(chatManagerDidUpdateStatusForMessage:withStatus:)])
//    {
//        [self.messageDelegate chatManagerDidReceiveMessage:message];
//        //if message controller is open and app is in background
//        if([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive)
//        {
//            if(message.sender != MessageSenderBot)
//            {
//            [self unreadCountNotification];
//            [Utility scheduleLocalNotificationForChat:message.text];
//            }
//            
//        }
//    }
//    else
//    {
//       [LocalStorage saveMessageForChatID:kChatId andMessage:message];
//        
//       if(message.sender != MessageSenderBot)
//       {
//           [ChatAccessor increaseUpdateCountOfUnreadMessagesForChatId:kChatId];
//           
//           
//           [self unreadCountNotification];
//           
//            if([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive)
//           {
//               [Utility scheduleLocalNotificationForChat:message.text];
//           }
//           else
//           {
//               [Utility playNotification];
//               
//           }
//       }
//    
//    }
//}


- (void)unreadCountNotification
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kNotificaionForUnreadCount
     object:self];

}

//- (void)gateWay:(GateWay *)gateWay didUpdatedConnetionStatus:(ConnectionStatus)connectionStatus
//{
//    
//    if(self.messageDelegate)
//    {
//    [self.messageDelegate chatManagerDidReceiveConnectionStatus:connectionStatus];
//    }
//    else
//    {
//        if(connectionStatus != ConnectionStatusConnected)
//        {
//            [self disconnectWithoutPrompting];
//            [self performSelector:@selector(connect) withObject:nil afterDelay:kReconnectInterval];
//        }
//    }
//    
//    //Send Pending Messages if Any
//    if(connectionStatus == ConnectionStatusConnected)
//    {
//        //Send Pending Messages
//        [self performSelector:@selector(sendPendingMessages) withObject:nil afterDelay:0.8];
//    }
//
//}
//
//
//- (void)gateWay:(GateWay *)gateWay didReceiveTypingStatus:(BOOL)isTyping{
//    
//    if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(chatManagerDidReceiveTyping:)])
//    {
//        [self.messageDelegate chatManagerDidReceiveTyping:isTyping];
//        
//        if(isTyping){
//            
//            [self performSelector:@selector(stopTypingStatus) withObject:nil afterDelay:2.0];
//        }
//    }
//    
//}

//- (void)gateWayDidSentMessageWithId:(NSString *)messageId
//{
//    if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(chatManagerDidUpdateStatusForMessage:withStatus:)])
//    {
//        [self.messageDelegate chatManagerDidUpdateStatusForMessage:messageId withStatus:MessageStatusSent];
//    }
//    else
//    {
//        [ChatAccessor updateStatus:MessageStatusSent forMessageId:messageId];
//    }
//}
//
//
//- (void)gateWayDidFailedToSendMessageWithId:(NSString *)messageId
//{
//    if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(chatManagerDidUpdateStatusForMessage:withStatus:)])
//    {
//        [self.messageDelegate chatManagerDidUpdateStatusForMessage:messageId withStatus:MessageStatusFailed];
//    }
//    else
//    {
//      [ChatAccessor updateStatus:MessageStatusSent forMessageId:messageId];
//    }
//
//}
//
//- (void)gatewayDidDeilveredMessageWithId:(NSString *)messageId
//{
//    if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(chatManagerDidUpdateStatusForMessage:withStatus:)])
//    {
//        [self.messageDelegate chatManagerDidUpdateStatusForMessage:messageId withStatus:MessageStatusReceived];
//    }
//    else
//    {
//      [ChatAccessor updateStatus:MessageStatusReceived forMessageId:messageId];
//    }
//}
//
//
//- (void)gatewayDidAgentLeftTheRoom
//{
//    if(!self.messageDelegate)
//    {
//        [[ChatManager sharedChatManager] disconnectWithoutPrompting];
//        [self performSelector:@selector(connect) withObject:nil afterDelay:kReconnectInterval];
//    }
//    else
//    {
//        [self.messageDelegate chatManagerDidAgentLeftTheRoom];
//    }
//    
//}
//
//
//- (void)gatwayAgentDeclinedChatRequest
//{
//    [self.messageDelegate chatManagerAgentDeclinedChatRequest];
//}
//
//
//- (void)gateWayDidReceivePing
//{
//    [self.messageDelegate chatMangetDidReceivePing];
//}


#pragma mark - send Pending Messages
- (void)sendPendingMessages
{
    NSArray *sendingMessageArray =  [ChatAccessor getSendingMessageArrayForChatId:kChatId];
    
    if([sendingMessageArray count]>0)
    {
        for(GFMessage *message in sendingMessageArray)
        {
            //Cast Message
            Message *msgToSend = [self getParsedMessage:message];
            [[ChatManager sharedChatManager] sendMessage:msgToSend];
        }
    }
    
}


//Parse Message from GFMessage

- (Message *)getParsedMessage:(GFMessage*)gfMessage
{
    Message *message = [[Message alloc] init];
    message.text = gfMessage.messageText;
    message.status = MessageStatusSending;
    message.chat_id = _chat.identifier;
    
    message.imageUrl  = gfMessage.imageUrl;
    message.messageId = gfMessage.messageId;
    message.messageText  = gfMessage.messageText;
    message.messageTime =  [gfMessage.messageTime doubleValue];
    message.messageType = gfMessage.messageType;
    message.reciver = gfMessage.receiver;
    message.senderId = gfMessage.sender;
    message.userType = [gfMessage.userType stringValue];
    
    return message;
}


@end
