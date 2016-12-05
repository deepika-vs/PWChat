//
//  RichTextEditorVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 30/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "RichTextEditorVC.h"
#import "ZSSDemoPickerViewController.h"


#import "DemoModalViewController.h"

@interface RichTextEditorVC ()
@property (nonatomic, strong) UITextField *textField;

@end

@implementation RichTextEditorVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;

    // HTML Content to set in the editor
    self.title = @"Standard";
    
    self.alwaysShowToolbar = NO;
    self.receiveEditorDidChangeEvents = NO;
    
    // HTML Content to set in the editor
//    NSString *html = @"<!-- This is an HTML comment -->"
//    "<p>This is a test of the <strong>ZSSRichTextEditor</strong> by <a title=\"Zed Said\" href=\"http://www.zedsaid.com\">Zed Said Studio</a></p>";
    
    // Set the base URL if you would like to use relative links, such as to images.
    self.baseURL = [NSURL URLWithString:@"http://www.zedsaid.com"];
    // Set the HTML contents of the editor
   // [self setPlaceholder:@"Enter Content Here..."];
    
    
    //self.shouldShowKeyboard = YES;
    // [self setHTML:html];
}

- (void)showInsertURLAlternatePicker {
    
    [self dismissAlertView];
    
    ZSSDemoPickerViewController *picker = [[ZSSDemoPickerViewController alloc] init];
    picker.demoView = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:picker];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:nil];
    
}


- (void)showInsertImageAlternatePicker {
    
    [self dismissAlertView];
    
    ZSSDemoPickerViewController *picker = [[ZSSDemoPickerViewController alloc] init];
    picker.demoView = self;
    picker.isInsertImagePicker = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:picker];
    nav.navigationBar.translucent = NO;
    [self presentViewController:nav animated:YES completion:nil];
    
}


- (void)exportHTML {
    
    NSLog(@"%@", [self getHTML]);
    
    //NSLog(@"%@", [self getText]);
    
    //For testing issues with returning to the editor from another view.
    
    //DemoModalViewController *destViewController = [[DemoModalViewController alloc] init];
    //[self presentViewController:destViewController animated:NO completion:nil];
    
}

- (void)editorDidChangeWithText:(NSString *)text andHTML:(NSString *)html {
    
    //NSLog(@"Text Has Changed: %@", text);
    
    //NSLog(@"HTML Has Changed: %@", html);
    
}

- (void)hashtagRecognizedWithWord:(NSString *)word {
    
    NSLog(@"Hashtag has been recognized: %@", word);
    
}

- (void)mentionRecognizedWithWord:(NSString *)word {
    
    NSLog(@"Mention has been recognized: %@", word);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
