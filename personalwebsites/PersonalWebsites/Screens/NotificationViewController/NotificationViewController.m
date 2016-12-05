//
//  NotificationViewController.m
//  PersonalWebsites
//
//  Created by VectoScalar on 20/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "NotificationViewController.h"

#define kNotificationTitle  @"Notification"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.needToShowBackButton = YES;
    [self createNavigationBarLeftItems];
    
    self.navigationItem.title = kNotificationTitle;
    
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
