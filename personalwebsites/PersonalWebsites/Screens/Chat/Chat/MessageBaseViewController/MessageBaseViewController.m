//
//  BaseViewController.m
//  SportInfo
//
//  Created by VectoScalar on 4/21/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "MessageBaseViewController.h"
//#import "MBProgressHUD.h"
#import "ChatController.h"
#import "MessageController.h"

//Back Button
#define kBackArrowLeftPadding 0
#define kBackArrowTopPadding 12
#define kAppLogoTopPadding 23
#define kBackArrowWidth 21
#define kBackArrowSize 45
#define kBackArrowHeight 21
#define kNavigationBarTextRightPadding 110
#define kScreenNameTopPadding 0
#define kBackArrowImageName @"backIcon.png"
#define kAdjustMentFactor 17

#define kTitlePadding 10
#define kNegativeMargin -8

//----FLoating COnstants---//
#define kFloatingButtonSize  (kScreenSize.width/5.3)
#define kMsgIconSize (kFloatingButtonSize/2.6)



#define kScreenWidth [[UIScreen mainScreen]bounds].size.width
#define kScreenHeight [[UIScreen mainScreen]bounds].size.height

#define kXCoordinate kFloatingButtonSize/1.8
#define kXRightCoordinate kScreenWidth - kFloatingButtonSize/1.8

#define kChatBubbleColor [UIColor colorWithRed:70.0/255.0f green:150.0/255.0f blue:156.0f/255.0f alpha:1.0]
#define kBadgeBackgroundColor [UIColor colorWithRed:33.0/255.0f green:211.0/255.0f blue:143.0f/255.0f alpha:1.0]

#define kMsgBadgeSize (kFloatingButtonSize/3)
#define kMsgBadgeRadius (kMsgBadgeSize/2) //Half of size
#define kMsgBadgeBordeWidth 2.0f
#define kMsgbadgeFontSize 11

#define kNavBarSize 64
#define kBottomBarSize 44

#define kChatBubbleImage @"chatBg.png"
#define kChatIcon @"chatMsg.png"

#define kBubbleAnimtaionDelay .3f

///----floating constatn ends---//

@interface MessageBaseViewController (){
 //   MBProgressHUD *_hud;
    UILabel *lblBadge;
}

@end

@implementation MessageBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(manageUnreadCount:)
                                                 name:kNotificaionForUnreadCount
                                               object:nil];
    
    // Do any additional setup after loading the view.
    [self createNavigationBarLeftItemsView];
}

-(void)getPurpleStatusViewForNavBar:(UINavigationBar *)navBar{
    navBar.hidden = NO;
    navBar.backgroundColor = kNavbarColor;
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navBar.shadowImage = [UIImage new];
    navBar.translucent = YES;

}
//
//-(void)removeStatusViewForNavBar:(UINavigationBar *)navBar{
//    //navBar.hidden = NO;
//    navBar.backgroundColor = [UIColor clearColor];
//    [statusView removeFromSuperview];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNavigationBarLeftItemsView{
    //Disable default back button
    self.navigationController.navigationItem.backBarButtonItem = nil;
    
    //Left View to put back button and logo image
    UIView *leftBarView = [[UIView alloc] initWithFrame:CGRectZero];
    leftBarView.backgroundColor=[UIColor clearColor];
    
    CGFloat xPointer = kBackArrowLeftPadding;
    CGFloat yPonter = kBackArrowTopPadding;
    
    if(!self.needToHideBackButton){
        //Arrow Image View
        UIButton *btnBackArrow = [[UIButton alloc] initWithFrame:CGRectMake(xPointer,
                                                                            yPonter,
                                                                            kBackArrowWidth,
                                                                            kBackArrowHeight)];
        btnBackArrow.backgroundColor=[UIColor clearColor];
        [btnBackArrow setImage:[UIImage imageNamed:kBackArrowImageName ] forState:UIControlStateNormal];
        [btnBackArrow addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [leftBarView addSubview:btnBackArrow];
        
        xPointer = xPointer + btnBackArrow.frame.size.width;
    }
    
    //Title text
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          kRobotoMedium(17), NSFontAttributeName,
                                          nil];
    
    CGFloat availableWidth = self.view.frame.size.width - xPointer - kBackArrowLeftPadding - kNavigationBarTextRightPadding;
    
    CGRect frame = [self.screenTitle boundingRectWithSize:CGSizeMake(availableWidth, 80)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:attributesDictionary
                                                  context:nil];
    
    _screenTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPointer + 15,
                                                                  8,
                                                                  frame.size.width,
                                                                  frame.size.height + 4)];
    _screenTitleLabel.backgroundColor = [UIColor clearColor];
    _screenTitleLabel.textColor = [UIColor whiteColor];
    _screenTitleLabel.font = kRobotoMedium(17);
    _screenTitleLabel.numberOfLines = 1;
    _screenTitleLabel.minimumScaleFactor = 9.0/15.0;
    _screenTitleLabel.adjustsFontSizeToFitWidth = YES;
    _screenTitleLabel.text = [self.screenTitle uppercaseString];
    [leftBarView addSubview:_screenTitleLabel];
    xPointer += _screenTitleLabel.frame.size.width + 10;
    
    CGFloat adjsutmentFactor = 0;
    
    if(_screenTitleLabel.text.length == 0)
    {
        adjsutmentFactor = 2*kAdjustMentFactor;
    }
    
    leftBarView.frame = CGRectMake(0,
                                   0,
                                   xPointer+adjsutmentFactor,
                                   kBackArrowHeight* 2);
    leftBarView.backgroundColor = [UIColor clearColor];
    //Button to perform action
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame= CGRectMake(leftBarView.frame.origin.x,
                                 leftBarView.frame.origin.y,
                                 leftBarView.frame.size.width+adjsutmentFactor,
                                 leftBarView.frame.size.height+adjsutmentFactor/1.5);
    backButton.backgroundColor=[UIColor clearColor];
    [backButton setHighlighted:YES];
    [leftBarView addSubview:backButton];
    [leftBarView bringSubviewToFront:backButton];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarView];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil action:nil];
    negativeSpacer.width = kNegativeMargin;
    
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,leftBarButtonItem]];
    

}



- (void)createNavigationTitleViewWithTitle:(NSString *)title andSubtitle:(NSString*)subTitle{
    
    
    
    //Disable default back button
    self.navigationController.navigationItem.backBarButtonItem = nil;
    
    
    //Left View to put back button and logo image
    UIView *leftBarView = [[UIView alloc] initWithFrame:CGRectZero];
    leftBarView.backgroundColor=[UIColor clearColor];
    
    
    CGFloat xPointer = kBackArrowLeftPadding;
    CGFloat yPonter = kBackArrowTopPadding;
    

        
        
        //Arrow Image View
        UIButton *btnBackArrow = [[UIButton alloc] initWithFrame:CGRectMake(xPointer,
                                                                            yPonter,
                                                                            kBackArrowWidth,
                                                                            kBackArrowHeight)];
        btnBackArrow.backgroundColor=[UIColor clearColor];
        [btnBackArrow setImage:[UIImage imageNamed:kBackArrowImageName ] forState:UIControlStateNormal];
        [btnBackArrow addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [leftBarView addSubview:btnBackArrow];
        
        xPointer = xPointer + btnBackArrow.frame.size.width+kTitlePadding;


    
    
    CGFloat availableWidth = kScreenSize.width-4*kTitlePadding;
    
    UIView *titleView  = [[UIView alloc]initWithFrame:CGRectMake(xPointer, 2, availableWidth, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(kTitlePadding, 2, availableWidth, 16)];
    lblTitle.text = title;
    lblTitle.font = kRobotoMedium(kFontSize12);
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.alpha = 0.6;
    
    UILabel *lblSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(kTitlePadding, 16, availableWidth-2*kTitlePadding, 28)];
    lblSubtitle.text =subTitle;
    lblSubtitle.font = kRobotoMedium(kFontSize16);
    lblSubtitle.textColor = [UIColor whiteColor];


    
    [titleView addSubview:lblTitle];
    [titleView addSubview:lblSubtitle];
    [leftBarView addSubview:titleView];
    
    xPointer = availableWidth;
    
        leftBarView.frame = CGRectMake(0,
                                       0,
                                       xPointer,
                                       kBackArrowHeight* 2);
    
     //Button to perform action
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame= CGRectMake(leftBarView.frame.origin.x,
                                 leftBarView.frame.origin.y,
                                 kBackArrowSize+ kAdjustMentFactor,
                                 leftBarView.frame.size.height);
    backButton.backgroundColor=[UIColor clearColor];
    [backButton setHighlighted:YES];
    [leftBarView addSubview:backButton];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarView];
    
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil action:nil];
    negativeSpacer.width = kNegativeMargin;
    
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,leftBarButtonItem]];
    

    
    
    
    
}


- (void)createUserChatImageAndStatusView
{
   
  
    [self.navTitleView configureUI];
    
    
    //Disable default back button
    self.navigationController.navigationItem.backBarButtonItem = nil;
    
    
    //Left View to put back button and logo image
    UIView *leftBarView = [[UIView alloc] initWithFrame:CGRectZero];
    leftBarView.backgroundColor=[UIColor clearColor];
    
    
    CGFloat xPointer = kBackArrowLeftPadding;
    CGFloat yPonter = kBackArrowTopPadding;
    
    
    
    
    //Arrow Image View
    UIButton *btnBackArrow = [[UIButton alloc] initWithFrame:CGRectMake(xPointer,
                                                                        yPonter,
                                                                        kBackArrowWidth,
                                                                        kBackArrowHeight)];
    btnBackArrow.backgroundColor=[UIColor clearColor];
    [btnBackArrow setImage:[UIImage imageNamed:kBackArrowImageName ] forState:UIControlStateNormal];
    [btnBackArrow addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftBarView addSubview:btnBackArrow];
    
    xPointer = xPointer + btnBackArrow.frame.size.width;
    
    self.navTitleView = (MessagingHeaderView *)[[[NSBundle mainBundle] loadNibNamed:@"MessagingHeaderView" owner:nil options:nil] firstObject];
    self.navTitleView.frame = CGRectMake(xPointer+10,
                                         0,
                                         170,
                                         40);
    
    CGFloat availableWidth = kScreenSize.width/1.4;
    
    [leftBarView addSubview:self.navTitleView];
    
    xPointer = availableWidth;
    
    leftBarView.frame = CGRectMake(0,
                                   0,
                                   xPointer/3,
                                   kBackArrowHeight* 2);
    
    //Button to perform action
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame= CGRectMake(leftBarView.frame.origin.x,
                                 leftBarView.frame.origin.y,
                                 leftBarView.frame.size.width,
                                 leftBarView.frame.size.height);
    backButton.backgroundColor=[UIColor clearColor];
    [backButton setHighlighted:YES];
    [leftBarView addSubview:backButton];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor = [UIColor clearColor];
    
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarView];

    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil action:nil];
    negativeSpacer.width = kNegativeMargin;
    
 
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,leftBarButtonItem]];
    
}


- (void)createNavigationBarRightItemsView{
    
}

- (void)backButtonPressed:(id)sender{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Public Methods

- (void)showProgressView{
    
//    if(!_hud){
//        
//        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        _hud.mode = MBProgressHUDModeAnnularDeterminate;
//        _hud.label.text = @"Loading";
//        
//    }
//    [_hud showAnimated:YES];
//    
}

- (void)hideProgressView{
   // [_hud hideAnimated:YES];
}


#pragma mark - FLoating Icon

- (void)createFloatingViewWithBadgeCount
{
    if(!self.floatingView)
    {
        self.floatingView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kFloatingButtonSize, kFloatingButtonSize)];
   // self.floatingView.backgroundColor = kChatBubbleColor;
   // self.floatingView.layer.cornerRadius = kFloatingButtonSize/2;
    [self.view addSubview:self.floatingView];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.floatingView.frame];
        imgView.image = [UIImage imageNamed:kChatBubbleImage];
        [self.floatingView addSubview:imgView];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    [self.floatingView addGestureRecognizer:panGestureRecognizer];
    
    //[[UIApplication sharedApplication].keyWindow addSubview:floatingView];
    
    
    UIImageView *msgImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
    msgImgView.image = [UIImage imageNamed:kChatIcon];
    msgImgView.contentMode = UIViewContentModeScaleAspectFit;
    msgImgView.frame = CGRectMake(kFloatingButtonSize/2-kMsgIconSize/2-2,
                                  kFloatingButtonSize/2-kMsgIconSize/2+2,
                                  kMsgIconSize,
                                  kMsgIconSize);
    
    lblBadge = [[UILabel alloc]initWithFrame:CGRectMake(msgImgView.frame.origin.x+kMsgIconSize-8,
                                                                 msgImgView.frame.origin.y-10,
                                                                 kMsgBadgeSize,
                                                                 kMsgBadgeSize)];
        
    
        [self configureBadgeLabel];
    lblBadge.backgroundColor = kBadgeBackgroundColor;
    lblBadge.layer.masksToBounds = YES;
    lblBadge.layer.cornerRadius = kMsgBadgeRadius;
    lblBadge.layer.borderColor = kChatBubbleColor.CGColor;
    lblBadge.layer.borderWidth = kMsgBadgeBordeWidth;
    lblBadge.textAlignment = NSTextAlignmentCenter;
    lblBadge.font =  [UIFont boldSystemFontOfSize:kMsgbadgeFontSize];
    // [lblBadge setFont:[lblBadge.font fontWithSize:15]];
    lblBadge.textColor = [UIColor whiteColor];
    [self.floatingView addSubview:lblBadge];
    [self.floatingView addSubview:msgImgView];
    
    [self.floatingView bringSubviewToFront:lblBadge];
    

    [self.floatingView setCenter:CGPointMake(kScreenWidth - kFloatingButtonSize/1.2,(self.visbleFrame.origin.y+self.visbleFrame.size.height)-kFloatingButtonSize/1.2)];
    
    [self tapGestureForFloatingButton];
    }
    else
    {
        [self configureBadgeLabel];
    }
    
}



- (void)tapGestureForFloatingButton
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(floatingButtonTapped)];
    [self.floatingView addGestureRecognizer:gesture];
}


- (void)floatingButtonTapped
{
    [self openMessageController];
}


- (void)openChatController
{
    UIViewController *viewController =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"Chat"];
    
    [(UINavigationController *)self.tabBarController.selectedViewController pushViewController:viewController animated:NO];
}


- (void)openMessageController
{
    MessageController *controller = (MessageController*)[[UIStoryboard storyboardWithName:@"Main"
                                                                                   bundle:NULL] instantiateViewControllerWithIdentifier:@"Message"];
    
    NSArray *allChats = [ChatAccessor getAllChats];
    
    
    
    if(allChats && [allChats count]>0)
    {
        GFChat *chat = [allChats objectAtIndex:0];
        controller.selectedChatId = chat.chatID;
        controller.selectedChat = chat;
    }
    
    controller.hidesBottomBarWhenPushed = YES;
    [(UINavigationController *)self.tabBarController.selectedViewController pushViewController:controller animated:YES];
}

#pragma mark - Touches Delegate

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch= [touches anyObject];
    if ([touch view] == self.floatingView)
    {
        DebugLog(@"---Touches Began");
    }
    
    
}

- (void)touchesEnded:(CGPoint)touchPoint
{
    DebugLog(@"---Touches Ended");
    
    CGFloat screenXOrigin = kScreenWidth/2;
    
    //Check for Top Left Corner
    if(touchPoint.x < kFloatingButtonSize/2 && touchPoint.y <(kFloatingButtonSize/2+self.visbleFrame.origin.y))
    {
        DebugLog(@"Move to top left");
        [self moveButtonToPosition:CGPointMake(kFloatingButtonSize/2,kFloatingButtonSize/1.8+self.visbleFrame.origin.y)];
    }
    //Check for Top Right Corner
    else if((touchPoint.x > kScreenWidth - kFloatingButtonSize/2) && (touchPoint.y <(kFloatingButtonSize/2+self.visbleFrame.origin.y)))
    {
        DebugLog(@"Move to top right");
        [self moveButtonToPosition:CGPointMake(kScreenWidth - kFloatingButtonSize/2,kFloatingButtonSize/1.8+self.visbleFrame.origin.y)];
    }
    //Check for Botttom Left Corner
    else if(touchPoint.x < kFloatingButtonSize/2 && touchPoint.y > (self.visbleFrame.origin.y+self.visbleFrame.size.height-kFloatingButtonSize/2))
    {
        DebugLog(@"Move to Bottom Left");
        [self moveButtonToPosition:CGPointMake(kFloatingButtonSize/2, (self.visbleFrame.origin.y+self.visbleFrame.size.height-kFloatingButtonSize/1.6))];
    }
    //Check for Bottom Right Corner
    else if(touchPoint.x > kScreenWidth - kFloatingButtonSize/2 && touchPoint.y > (self.visbleFrame.origin.y+self.visbleFrame.size.height-kFloatingButtonSize/2))
    {
        DebugLog(@"Move to Bottom right");
        [self moveButtonToPosition:CGPointMake(kScreenWidth - kFloatingButtonSize/2,(self.visbleFrame.origin.y+self.visbleFrame.size.height-kFloatingButtonSize/1.6))];
    }
    else
    {
        DebugLog(@"Set Default Postion");
        
        CGFloat yPos = touchPoint.y;
        
        if(touchPoint.y > (self.visbleFrame.origin.y +self.visbleFrame.size.height)   -kFloatingButtonSize/2)
        {
            yPos = self.visbleFrame.origin.y +self.visbleFrame.size.height-kFloatingButtonSize/1.6;
        }
        //For top pos
        if(touchPoint.y < (kFloatingButtonSize/2+self.visbleFrame.origin.y))
        {
            yPos = kFloatingButtonSize/1.8+self.visbleFrame.origin.y;
        }
        //Place button left or right according to x - Coordinate
        if(touchPoint.x > screenXOrigin)
        {
            [self moveButtonToPosition:CGPointMake(kXRightCoordinate,yPos)];
        }
        else
        {
            [self moveButtonToPosition:CGPointMake(kXCoordinate,yPos)];
            
        }
    }
    
}


- (void)moveButtonToPosition:(CGPoint)point
{
    [UIView animateWithDuration:kBubbleAnimtaionDelay animations:^{
        [self.floatingView setCenter:point];
    }];
}


-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
    CGPoint touchPoint = [panGestureRecognizer locationInView:self.view];
    
    DebugLog(@"--_%@",NSStringFromCGPoint(touchPoint));
    DebugLog(@"---Touches Moved");
    
    //Check if Button not cross the screen bondary
    //Left Restriction
    if(touchPoint.x < kFloatingButtonSize/2 )
    {
        DebugLog(@"--Left Restriction");
        if(touchPoint.y>self.visbleFrame.origin.y+kFloatingButtonSize/2 &&  touchPoint.y < (self.visbleFrame.origin.y+self.visbleFrame.size.height-kFloatingButtonSize/2))
        {
            [self.floatingView setCenter:CGPointMake(self.floatingView.center.x, touchPoint.y)];
        }
        
    }
    //Right Restriction
    else  if(touchPoint.x > kScreenWidth - kFloatingButtonSize/2)
    {
        
        DebugLog(@"--Right Restriction");
        if(touchPoint.y >self.visbleFrame.origin.y+kFloatingButtonSize/2 && touchPoint.y < (self.visbleFrame.origin.y+self.visbleFrame.size.height-kFloatingButtonSize/2))
        {
            DebugLog(@"-- Inside Right Restriction");
            [self.floatingView setCenter:CGPointMake(self.floatingView.center.x, touchPoint.y)];
        }
    }
    //Top Restriction
    else  if(touchPoint.y < self.visbleFrame.origin.y+kFloatingButtonSize/2)
    {
        
        [self.floatingView setCenter:CGPointMake(touchPoint.x, self.floatingView.center.y)];
    }
    //Bottom Restriction
    else  if(touchPoint.y > (self.visbleFrame.origin.y+self.visbleFrame.size.height-kFloatingButtonSize/2))
    {
        [self.floatingView setCenter:CGPointMake(touchPoint.x, self.floatingView.center.y)];
    }
    else
    {
        [self.floatingView setCenter:CGPointMake(touchPoint.x,touchPoint.y)];
    }
    DebugLog(@"Touch x : %f y : %f", touchPoint.x, touchPoint.y);
    
    if(panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        //All fingers are lifted.
        [self touchesEnded:touchPoint];
    }
    
}


- (void)manageUnreadCount:(NSNotification*)notification
{
    if ([[notification name] isEqualToString:kNotificaionForUnreadCount])
    {
       // [Utility showAlerWithMessage:@"increment unread count"];
        [self configureBadgeLabel];
        
        
    }
}


- (void)configureBadgeLabel
{
    int unreadCount = [ChatAccessor getUnreadCountForChatId:kChatId];
    if(unreadCount>0)
    {
        lblBadge.text = [NSString stringWithFormat:@"%d",unreadCount];
        lblBadge.hidden = NO;
    }
    else
    {
        [self hideMessageCount];
    }
}

- (void)hideMessageCount
{
  lblBadge.hidden  = YES;
}



- (void)openMessageControllerViaNavigationController
{
    MessageController *controller = (MessageController*)[[UIStoryboard storyboardWithName:@"Main"
                                                                                   bundle:NULL] instantiateViewControllerWithIdentifier:@"Message"];
    
    NSArray *allChats = [ChatAccessor getAllChats];
    
    
    
    if(allChats && [allChats count]>0)
    {
        GFChat *chat = [allChats objectAtIndex:0];
        controller.selectedChatId = chat.chatID;
        controller.selectedChat = chat;
    }
    [self.navigationController pushViewController:controller animated:YES];
}


@end
