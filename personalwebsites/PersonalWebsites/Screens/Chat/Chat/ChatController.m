//
//  ChatListController.m
//  Whatsapp
//
//  Created by Rafael Castro on 7/24/15.
//  Copyright (c) 2015 HummingBird. All rights reserved.
//

#import "ChatController.h"
#import "MessageController.h"

#import "ChatCell.h"
#import "Chat.h"
#import "LocalStorage.h"
#import "ChatManager.h"
#import "AppDelegate.h"
#import "ChatAccessor.h"

@interface ChatController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong,nonatomic) ChatManager *chatManager;
@property (strong,nonatomic) Message *dummyMessage;
@end


@implementation ChatController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setTableView];
  //  [self setTest];
    
    self.title = @"Chats";
    
    self.navigationController.navigationBar.barTintColor =kNavbarColor;

    
    
    self.chatManager = [ChatManager sharedChatManager];
    //self.chatManager.chatCtrlDelegate = self;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    

    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if(appDelegate.isComingFromMessageController)
       {
           appDelegate.isComingFromMessageController = NO;
           [self.navigationController popViewControllerAnimated:NO];
       }
    else
    {
        MessageController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Message"];
       
        NSArray *allChats = [ChatAccessor getAllChats];
        
  
        
        if(allChats && [allChats count]>0)
        {
            GFChat *chat = [allChats objectAtIndex:0];
            controller.selectedChatId = chat.chatID;
            controller.selectedChat = chat;
        }
        
        appDelegate.isComingFromMessageController = YES;
        //[self.navigationController pushViewController:controller animated:NO];
    }
    
   

    
}
-(void)setTableView
{
    self.tableData = [[NSMutableArray alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,self.view.frame.size.width, 10.0f)];
    self.tableView.backgroundColor = [UIColor clearColor];
}



//TODO: Load Data From 
-(void)setTest
{
    Contact *contact = [[Contact alloc] init];
    contact.name = @"Stuart";
    contact.identifier = @"12345";
    
    Chat *chat = [[Chat alloc] init];
    chat.contact = contact;
    
  
    
    Message *last_message = nil;
  
    Message *message = [[Message alloc] init];
    message.text = @"Is it close enough?";
    message.sender = MessageSenderSomeone;
    message.status = MessageStatusReceived;
    message.chat_id = chat.identifier;
    
    [[LocalStorage sharedInstance] storeMessage:message];
    last_message = message;

    
    chat.numberOfUnreadMessages = 2;
    chat.last_message = last_message;

    [self.tableData addObject:chat];
    Chat *tmpChat = [self.tableData objectAtIndex:0];
    _dummyMessage = tmpChat.last_message;
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChatListCell";
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[ChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.chat = [self.tableData objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MessageController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Message"];
    controller.chat = [self.tableData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
