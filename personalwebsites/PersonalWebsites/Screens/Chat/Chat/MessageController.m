//
//  MessageController.m
//  Whatsapp
//
//  Created by Rafael Castro on 7/23/15.
//  Copyright (c) 2015 HummingBird. All rights reserved.
//

#import "MessageController.h"
#import "TableArray.h"
#import "ChatManager.h"

#import "Inputbar.h"
#import "DAKeyboardControl.h"
#import "MessagingHeaderView.h"

#import "NewMessageCell.h"
#import "OnlineStatusCell.h"
#import "ChatUICell.h"

#define kUserImage @"userImg.png"
#define kSampleTimeText @"59:59 PM"


#define kXPadding 8
#define kYPadding 2
#define kImageSize 38

#define kChatTimeGap 4

#define kBorderWidth 0.9f
#define kBorderRadius 2.0f

//Fonts

#define kChatFont  kRobotoRegular(kFontSize14)
#define kTimeFont  kRobotoRegular(kFontSize10)

#define kOnlineStatusCell @"OnlineStatusCell"
#define kNavTitle @"GoFro Messenger"
#define kConnectedMessage @"Online"
#define kDiconnectMessage @"Disconnected"
#define kAgentLeftTheRoomMessage @"Agent has left the room"
#define KUserStatusMessage @"Typing..."
#define kDefaultMessage @"Help for all your on trip queries"
#define kMessagCellIdentifier @"NewMessageCell"
#define kConnectingText @"Connecting"
#define kUnableToConnect @"No Destination Expert Available"
#define kCancel @"Cancel"
#define kRetry @"Retry"
#define kSearchAnotherAgent @"Search Another Agent"
#define kAgentDeclineMessage @"Agent has decline the Request. Searching Another..."
#define kAgentJoinMessage @"Agent has joined the Chat"
#define kChatUICell @"ChatUICell"


#define kKeyboardHeightConstant 250
#define kConnectingLabelWidth 64
#define kConnectingLabelHeight 20
#define kConnectingViewWidht 80
#define kConnectingViewHeight 40
#define kExpertStatusRowHeight 60


@interface MessageController() <InputbarDelegate, MessageManagerDelegate,
UITableViewDataSource, UITableViewDelegate,ChatUICellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet Inputbar *inputbar;
@property (strong, nonatomic) TableArray *tableArray;
@property (strong, nonatomic) ChatManager *chatManager;

@property (strong,nonatomic) UIActivityIndicatorView *activityIndicator;
@property (assign,nonatomic) BOOL isConnectionMade;

@property (strong,nonatomic) NSMutableArray *displayedMessages;

@end




@implementation MessageController
{
    UIView *loadingView ;
    UILabel *agentDeclineReqLabel;
}

-(void)viewDidLoad
{
    
    [super viewDidLoad];

    //Input Bat used to type and send message
      [self setInputbar];
    
    //Configure Table View
     [self setTableView];
    
    //Load Previous messages
     [self setGateway];
    
    //Navigation title View
     [self createUserChatImageAndStatusView];
    
    //Nav Bar Customizations
     [self customizNavBar];
    
    //What to do when first launch
    [self handleFirstLaunch];
    
    self.hidesBottomBarWhenPushed = YES;

}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if(![[ChatManager sharedChatManager] isChatConnected])
    {
      // if([Utility isConnectedToInternet])
    //   {
            [self showConnectingView];
            [[ChatManager sharedChatManager] connect];
       // }
//         else
//        {
//            [Utility showAlerWithMessage:kNoInternetMessage onViewController:self];
//            [self hideConnectingView];
//        }
    }
    else
    {
        [self connectionToChatSucceed];
    }
    
    
    //Clear the Unread Count
    [ChatAccessor resetUnreadCountForChatId:kChatId];
    
    [self hideMessageCount];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
//    

    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __weak Inputbar *inputbar = _inputbar;
    __weak UITableView *tableView = _tableView;
    __weak MessageController *controller = self;
    
    self.view.keyboardTriggerOffset = inputbar.frame.size.height;
    [self.view addKeyboardPanningWithActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
        /*
         Try not to call "self" inside this block (retain cycle).
         But if you do, make sure to remove DAKeyboardControl
         when you are done with the view controller by calling:
         [self.view removeKeyboardControl];
         */
        
        CGRect toolBarFrame = inputbar.frame;
        toolBarFrame.origin.y = keyboardFrameInView.origin.y - toolBarFrame.size.height;
        inputbar.frame = toolBarFrame;
        
        CGRect tableViewFrame = tableView.frame;
        tableViewFrame.size.height = toolBarFrame.origin.y - 64;
        tableView.frame = tableViewFrame;
        
        [controller tableViewScrollToBottomAnimated:NO];
    }];
    
     [[NSNotificationCenter defaultCenter] postNotificationName:kVoucherNotificationReceivedLocalKey object:self];

    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
    [self.view removeKeyboardControl];
    self.chatManager.messageDelegate = nil;
    [self.chatManager dismiss];
    //[statusView removeFromSuperview];
    //self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    //TODO:Removed due to new implementation
//    if(!self.isConnectionMade)
//    {
//        [[ChatManager sharedChatManager] disconnectWithoutPrompting];
//        [self resetConnectionState];
//        [self.navTitleView updateLabelsWithName:kNavTitle andStatus:kDefaultMessage];
//    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.chat.last_message = [self.tableArray lastObject];
}


- (void)handleFirstLaunch
{
    GFChat *chat = [ChatAccessor getChatForChatId:kChatId];
    NSArray *array = [chat.messages allObjects];
    if([array count]==0)
    {
        self.tableView.hidden = YES;
        self.contentView.hidden = NO;
    }
    else
    {
        self.tableView.hidden = NO;
        self.contentView.hidden = YES;
    }
    
}


- (void)rightNavigationButtonPressed
{
    NSLog(@"---rightNavigationButtonPressed----@");
}

- (void)customizNavBar
{
    
    self.navigationItem.titleView = [UIView new];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.backgroundColor = kNavbarColor;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
    //TODO::Not in this release
    
}


- (void)showConnectingView
{
    loadingView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kConnectingViewWidht, kConnectingViewHeight)];
    
    UILabel *lblConnecting = [[UILabel alloc] initWithFrame:CGRectMake(10, loadingView.frame.size.height/2-kConnectingLabelHeight/2, kConnectingLabelWidth, kConnectingLabelHeight)];
    lblConnecting.text = kConnectingText;
    lblConnecting.font =  kRobotoRegular(kFontSize11);
    lblConnecting.textColor = [UIColor whiteColor];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.activityIndicator hidesWhenStopped];
    [self.activityIndicator startAnimating];
    
    [loadingView addSubview:lblConnecting];
    self.activityIndicator.center = CGPointMake(loadingView.frame.origin.x+loadingView.frame.size.width+2, kConnectingViewHeight/2);
    [loadingView addSubview:self.activityIndicator];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:loadingView];
    self.navigationItem.rightBarButtonItem = rightBtn;
}


- (void)hideConnectingView
{
    loadingView.hidden = YES;
    [loadingView removeFromSuperview];
    [self.activityIndicator stopAnimating];
}



-(void)setInputbar
{
    self.inputbar.placeholder = nil;
    self.inputbar.delegate = self;
    self.inputbar.leftButtonImage = [UIImage imageNamed:kChatAttachment];
}


-(void)setTableView
{
    self.displayedMessages = [[NSMutableArray alloc]init];
    
    self.tableArray = [[TableArray alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,self.view.frame.size.width, 10.0f)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    UINib *nib = [UINib nibWithNibName:kMessagCellIdentifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kMessagCellIdentifier];
    
    //Online status cell
    nib = [UINib nibWithNibName:kOnlineStatusCell bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kOnlineStatusCell];
    
    //Chat cell
    nib = [UINib nibWithNibName:kChatUICell bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kChatUICell];
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 5, 0);
    //Autolayout Settings
   // self.tableView.rowHeight = UITableViewAutomaticDimension;
   // self.tableView.estimatedRowHeight = 38.0;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}



-(void)setGateway
{
    self.chatManager = [ChatManager sharedChatManager];
    self.chatManager.messageDelegate = self;
    self.chatManager.chat = self.chat;
    [self.chatManager loadOldMessages];
}
-(void)setChat:(Chat *)chat
{
    _chat = chat;
    self.title = chat.contact.name;
}

#pragma mark - Actions

- (IBAction)userDidTapScreen:(id)sender
{
    [_inputbar resignFirstResponder];
    [self inputbarDidChangeText:@""];
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tableArray numberOfSections];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableArray numberOfMessagesInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Message *currentMessage = [self.tableArray objectAtIndexPath:indexPath];
    
    if(currentMessage.sender != MessageSenderBot)
    {
        ChatUICell *cell =  [tableView dequeueReusableCellWithIdentifier:kChatUICell];
        
        cell.delegate = self;
        
        cell.message = [self.tableArray objectAtIndexPath:indexPath];
        DebugLog(@"---message Status--%d--text--%@",(int)currentMessage.status,currentMessage.text);
        
        if(![self.displayedMessages containsObject:currentMessage])
        {
            [self.displayedMessages addObject:currentMessage];
        }
        
        
        //Decide Whether need to show User Image or Not (Show only if sender is changed)
        BOOL needToShowImage = false;
        if(indexPath.row == 0){
            needToShowImage = true;
        }
        else{
            Message *previousMessage = [self.tableArray objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section]];
            needToShowImage = !(previousMessage.sender == currentMessage.sender);
        }
        
        [cell updateChatUIWithUserImageStatus:needToShowImage];
        
        return cell;

    }
    else
    {
        
        OnlineStatusCell *cell =  [tableView dequeueReusableCellWithIdentifier:kOnlineStatusCell];
        [cell updateOnlineStatus:currentMessage.text];
        return cell;
    
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
   Message *currentMessage = [self.tableArray objectAtIndexPath:indexPath];
        
   
    if(currentMessage.sender == MessageSenderBot)
    {
      return kExpertStatusRowHeight;
    }
    else
    {
        return  [self getHeightForMessage:currentMessage];
    }
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //return [self.tableArray titleForSection:section];
    return @"";
}

- (void)tableViewScrollToBottomAnimated:(BOOL)animated
{
    NSInteger numberOfSections = [self.tableArray numberOfSections];
    NSInteger numberOfRows = [self.tableArray numberOfMessagesInSection:numberOfSections-1];
    if (numberOfRows)
    {
        [_tableView scrollToRowAtIndexPath:[self.tableArray indexPathForLastMessage]
                          atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}

#pragma mark - InputbarDelegate

-(void)inputbarDidPressRightButton:(Inputbar *)inputbar
{
    
//    if(![Utility isConnectedToInternet])
//    {
//        [Utility showAlerWithMessage:kNoInternetMessage onViewController:self];
//        return;
//    }
    [self showChatTable];
    
    Message *message = [[Message alloc] init];
    message.text = [inputbar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    message.status = MessageStatusSending;
    message.chat_id = _chat.identifier;
    
    message.imageUrl  = @"";
    message.messageId = kTimeStamp;
    message.messageText  =inputbar.text;
    message.messageTime = [[NSDate date] timeIntervalSince1970] * 1000;
    message.messageType = @"";
    message.reciver = @"";
    message.senderId = @"";
    message.userType = @"0";
    
    //Store Message in memory
    [self.tableArray addObject:message];
    
    //Insert Message in UI
    // NSIndexPath *indexPath = [self.tableArray indexPathForMessage:message];
    
    [self.tableView reloadData];
    [self tableViewScrollToBottomAnimated:NO];
    
    //Send message to server only if Connected to chat server
    
    if(self.isConnectionMade)
    {
      [self.chatManager sendMessage:message];
    }
    else
    {
       [[LocalStorage sharedInstance] storeMessage:message];
    }
}


- (void)showChatTable
{
    self.tableView.hidden = NO;
    self.contentView.hidden = YES;
}

-(void)inputbarDidChangeText:(NSString *)text{
    
    if(text.length > 0){
        
        [[ChatManager sharedChatManager] updateTypingStatus:YES forChat:self.chat];
    }
    else{
        [[ChatManager sharedChatManager] updateTypingStatus:NO forChat:self.chat];
    }
    
}


-(void)inputbarDidChangeHeight:(CGFloat)new_height
{
    //Update DAKeyboardControl
    self.view.keyboardTriggerOffset = new_height;
}


#pragma mark - ChatManagerDelegate

-(void)chatManagerDidUpdateStatusForMessage:(NSString *)messageId withStatus:(MessageStatus)msgStatus
{
    Message *msgToUpdate;
    for(Message *message in self.displayedMessages)
    {
        NSLog(@"--%@---%@",message.text,message.messageId);
        if([message.messageId isEqualToString:messageId])
        {
            msgToUpdate = message;
            
            //Update Subtitle in Nav bar
            if(msgStatus != MessageStatusFailed && self.isConnectionMade)
            {
              [self.navTitleView updateLabelsWithName:kNavTitle andStatus:kAgentJoinMessage];
            }
            
            break;
        }
    }
    if(msgToUpdate)
    {
        
        msgToUpdate.status =  msgStatus;
        NSIndexPath *indexPath = [self.tableArray indexPathForMessage:msgToUpdate];
        
        ChatUICell *cell = (ChatUICell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell updateChatUIWithUserImageStatus:YES];
        [[LocalStorage sharedInstance] storeMessage:msgToUpdate];
    }
    
    
    
}

-(void)chatManagerDidReceiveMessage:(Message *)message
{
    [self.tableArray addObject:message];
    [[LocalStorage sharedInstance] storeMessage:message];
    [self handleFirstLaunch];
    [self.tableView reloadData];
    [self tableViewScrollToBottomAnimated:NO];
    
}

- (void)chatManagerFinishLoadingOlderMessage:(NSArray *)messages
{
    [self.tableArray addObjectsFromArray:messages];
    [self.tableView reloadData];
   // [self performSelector:@selector(scollToBottom) withObject:nil afterDelay:0.0];
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        
    CGPoint offset = CGPointMake(0, self.tableView.contentSize.height -     self.tableView.frame.size.height+4);
    [self.tableView setContentOffset:offset animated:YES];
    }
    
}

- (void)scollToBottom
{
    [self tableViewScrollToBottomAnimated:NO];
}



-(void)chatManagerDidReceivePresenceStatus:(PresenceStatus)presenceStatus{
    
}


-(void)chatManagerDidReceiveTyping:(BOOL)isTyping{
    
    
    if(isTyping){
        
        [self.navTitleView updateLabelsWithName:kNavTitle andStatus:KUserStatusMessage];
    }
    else{
        
        [self.navTitleView updateLabelsWithName:kNavTitle andStatus:kDefaultMessage];
    }
    
}


#pragma mark - Keyboard Handeling
- (void)inputbarDidBecomeFirstResponder:(Inputbar *)inputbar
{
    NSLog(@"---KeyBoard Open");
    
    [self changeContentViewFrameWithYOffset:-kKeyboardHeightConstant];
}


- (void)inputbarShouldEndEditing:(Inputbar *)inputbar
{
    NSLog(@"---KeyBoard Close");
    
    [self changeContentViewFrameWithYOffset:kKeyboardHeightConstant];
    
    
    
}


- (void)changeContentViewFrameWithYOffset:(CGFloat)offset
{
    CGRect frame = self.contentView.frame;
    
    frame.origin.y = frame.origin.y+offset;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.contentView.frame = frame;
        
    }];
    
    [UIView commitAnimations];
}


#pragma mark - Handle Error in Connection
- (void)chatManagerDidReceiveConnectionStatus:(ConnectionStatus)connectionStatus
{
    [self hideConnectingView];
    if(connectionStatus != ConnectionStatusConnected)
    {
        [[ChatManager sharedChatManager] disconnectWithoutPrompting];
        [self resetConnectionState];
        [self.navTitleView updateLabelsWithName:kNavTitle andStatus:kUnableToConnect];
        [self performSelector:@selector(reconnectWithChatServer) withObject:nil afterDelay:kReconnectInterval];
        //Uncomment below line to show a prompt
       // [self didConnectionToChatFailWithMessage:kChatConnectionErrorMessage withLeftButton:kCancel andRightButtonTitle:kRetry];
    }
    else
    {   //Connected
        [self connectionToChatSucceed];
        
        
    }
}





- (void)connectionToChatSucceed
{
    self.isConnectionMade = YES;
    
    [self.navTitleView updateLabelsWithName:kNavTitle andStatus:kConnectedMessage];
}


- (void)resetConnectionState
{
    self.isConnectionMade = NO;
}

- (void)didConnectionToChatFailWithMessage:(NSString*)message withLeftButton:(NSString*)leftButtonTitle andRightButtonTitle:(NSString*)rightButtonTitle
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:leftButtonTitle
                             style:UIAlertActionStyleDefault
                             handler:nil];
    
    UIAlertAction* retry = [UIAlertAction
                            actionWithTitle:rightButtonTitle
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                [self reconnectWithChatServer];
                            }];
    
    [alert addAction:cancel];
    [alert addAction:retry];
    
    [self presentViewController:alert animated:NO completion:nil];
    
    
    
}

- (void)reconnectWithChatServer
{
    
    NSLog(@"reconnectWithChatServer");
    [self showConnectingView];
    [self.navTitleView updateLabelsWithName:kNavTitle andStatus:kDefaultMessage];
    [[ChatManager sharedChatManager] connect];
    
}


- (void)chatManagetDidFailedToGetToken
{
    [self hideConnectingView];
    [self resetConnectionState];
    [self.navTitleView updateLabelsWithName:kNavTitle andStatus:kUnableToConnect];
    [self performSelector:@selector(reconnectWithChatServer) withObject:nil afterDelay:kReconnectInterval];
   // [Utility showAlerWithMessage:kChatConnectionErrorMessage onViewController:self];
}


#pragma  mark - Message Cell Deelgate
- (void)didUserTappedFailedMessage:(UITableViewCell *)cell
{
    NSLog(@"New UI Failed is working");
    
//    if(![Utility isConnectedToInternet])
//    {
//        [Utility showAlerWithMessage:kNoInternetMessage onViewController:self];
//        return;
//    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    Message *msgToUpdate = [self.tableArray objectAtIndexPath:indexPath];
    msgToUpdate.status = MessageStatusSending;
    NewMessageCell *msgCell = (NewMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [msgCell updateMessageStatus:YES];
    
    //Send message to server
    [self.chatManager sendMessage:msgToUpdate];
    
}



- (void)chatManagerDidAgentLeftTheRoom
{
    [[ChatManager sharedChatManager] disconnectWithoutPrompting];
    [self resetConnectionState];
    [self.navTitleView updateLabelsWithName:kNavTitle andStatus:kAgentLeftTheRoomMessage];
    
    [self performSelector:@selector(reconnectWithChatServer) withObject:nil afterDelay:kReconnectInterval];
    
     // [self didConnectionToChatFailWithMessage:kAgentLeftTheRoomMessage withLeftButton:kCancel andRightButtonTitle:kSearchAnotherAgent];
}


- (void)chatManagerAgentDeclinedChatRequest
{
    agentDeclineReqLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    agentDeclineReqLabel.backgroundColor = [UIColor blackColor];
    agentDeclineReqLabel.text = kAgentDeclineMessage;
    agentDeclineReqLabel.textColor = [UIColor whiteColor];
    agentDeclineReqLabel.alpha = 0.8;
    agentDeclineReqLabel.font = kRobotoMedium(18);
    CGSize labelSize = [Utility getTheSizeForText:kAgentDeclineMessage andFont:agentDeclineReqLabel.font toFitInWidth:kScreenSize.width-40];
    
    agentDeclineReqLabel.frame = CGRectMake(0, 0, kScreenSize.width-40, labelSize.height);
    
    agentDeclineReqLabel.center = self.view.center;
    [self.view addSubview:agentDeclineReqLabel];
    
    [self performSelector:@selector(removeDeclineMessage) withObject:nil afterDelay:2.5];
}


- (void)removeDeclineMessage
{
    [agentDeclineReqLabel removeFromSuperview];
    agentDeclineReqLabel= nil;
}

#pragma mark - Reachability Manager
//TODO:: reachabilityDidChange will not work on simulator
- (void)reachabilityDidChange:(NSNotification *)notification
{
    BOOL isNetworkConnectionLost = [Utility isNetworkConnectionLost];
    
    if(isNetworkConnectionLost)
    {
        NSLog(@"Netwrk Lost--Disconnect XMPP");
        //Only Show Connection view XMPPAutoPing will handle rest
        [self resetConnectionState];
        [self showConnectingView];
    }
}

#pragma mark - Ping Delegate

- (void)chatMangetDidReceivePing
{
    if(!self.isConnectionMade)
    {
        [self connectionToChatSucceed];
        [self hideConnectingView];
        
//         [[DataManager sharedDataManager] sendChatLogsForLogLevel:INFO withTag:@"Gateway" andLog:@"Reconnection Successful"];
    }
}



- (CGFloat)getHeightForMessage:(Message*)message
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
