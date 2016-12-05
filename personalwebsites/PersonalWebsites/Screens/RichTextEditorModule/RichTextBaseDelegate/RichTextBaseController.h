//
//  RichTextBaseController.h
//  PersonalWebsites
//
//  Created by vectoscalar on 05/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RichTextEditorVC.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@class RichTextBaseController;

@protocol RichTextBaseControllderDelegate <NSObject>

- (void)userDidSavedHTMLContent:(NSString*)htmlContent;

@end

@interface RichTextBaseController : RichTextEditorVC


@property (assign,nonatomic) BOOL needToShowBackButton;
@property (strong,nonatomic) NSString *screenTitle;

- (void)hideNavigationBackButton;
- (void)createNavigationBarLeftItems;

- (void)createRightNavigationItem;

@property (assign,nonatomic) id <RichTextBaseControllderDelegate> delegate;



@end
