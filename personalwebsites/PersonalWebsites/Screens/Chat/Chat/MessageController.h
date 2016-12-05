//
//  ChatController.h
//  Whatsapp
//
//  Created by Rafael Castro on 6/16/15.
//  Copyright (c) 2015 HummingBird. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chat.h"
#import "MessageBaseViewController.h"
#import "LocalStorage.h"
#import "ChatAccessor.h"
#import "BuyerAccessor.h"
//#import "Reachability.h"
//
// This class control chat exchange message itself
// It creates the bubble UI
//
@interface MessageController :MessageBaseViewController
@property (strong, nonatomic) Chat *chat;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong,nonatomic) NSString *selectedChatId;
@property (strong,nonatomic) GFChat *selectedChat;


@end
