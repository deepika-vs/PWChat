//
//  SignInViewController.m
//  ChatDemoProject
//
//  Created by VectoScalar on 22/11/16.
//  Copyright © 2016 vs. All rights reserved.
//

#import "SignInViewController.h"
#import "MessageController.h"
#import "ChatController.h"
@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpButtonPressed:(id)sender {
    
    MessageController *controller = (MessageController*)[[UIStoryboard storyboardWithName:@"Main"
                                                                                   bundle:NULL] instantiateViewControllerWithIdentifier:@"Message"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)didTapSignIn:(id)sender {
    
   UIViewController *controller = [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"Chat"];
    
   [self.navigationController pushViewController:controller animated:NO];

}
@end
