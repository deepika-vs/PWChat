
#import <Foundation/Foundation.h>
#import "Message.h"
#import "Chat.h"
#import "Media.h"
//#import "GateWay.h"

//#import "XMPP.h"
//#import "APIManager.h"
//#import "ChatTockenMapper.h"
//#import "XMPPMUC.h"
//#import "XMPPRoom.h"






@protocol MessageManagerDelegate <NSObject>

- (void)chatManagerDidUpdateStatusForMessage:(NSString *)messageId withStatus:(MessageStatus)messageStatus;
- (void)chatManagerDidReceiveMessage:(Message *)message;
- (void)chatManagerDidReceiveConnectionStatus:(ConnectionStatus)connectionStatus;
- (void)chatManagerDidReceivePresenceStatus:(PresenceStatus)presenceStatus;
- (void)chatManagerDidReceiveTyping:(BOOL)isTyping;
- (void)chatManagerFinishLoadingOlderMessage:(NSArray*)messages;
- (void)chatManagetDidFailedToGetToken;
- (void)chatManagerDidAgentLeftTheRoom;
- (void)chatManagerAgentDeclinedChatRequest;
- (void)chatMangetDidReceivePing;
@end

//
// this class is responsable to send message
// to server and notify status. It's also responsable
// to get messages in local storage.
//

@interface ChatManager : NSObject//<GateWayDelegate, APIManagerDelegate>
{
    //GateWay *_gateWay;
}

//@property (assign,nonatomic) id <MessageManagerDelegate> chatCtrlDelegate; will use to comunicate with Chat Controller

@property (assign,nonatomic) id <MessageManagerDelegate> messageDelegate;
@property (strong, nonatomic) Chat *chat;
//@property (strong, nonatomic) APIManager *apiManager;


+ (id)sharedChatManager;

- (void)connect;
- (void)disconnect;
- (void)disconnectWithoutPrompting;

- (void)loadOldMessages;
- (void)sendMessage:(Message *)message;
- (void)updateTypingStatus:(BOOL)isTyping forChat:(Chat *)chat;
- (void)shareMedia:(Media *)media;
- (void)news;
- (void)dismiss;
- (BOOL)isChatConnected;
- (void)writeOnFileLog:(NSString *)logText;
- (NSString *)getChatLogs;


@end
