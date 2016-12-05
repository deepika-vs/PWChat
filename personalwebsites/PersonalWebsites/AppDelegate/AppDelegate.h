//
//  AppDelegate.h
//  SportInfo
//
//  Created by VectoScalar on 4/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "MenuSliderViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MenuSliderViewController *menuSliderViewController;

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (assign,nonatomic) BOOL isComingFromMessageController;

@property (assign,nonatomic)BOOL isNetworkConnectionLost;

- (void)showProgressView;
- (void)hideProgressView;


- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

@end

