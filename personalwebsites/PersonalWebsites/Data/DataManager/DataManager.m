//
//  DataManager.m
//  PersonalWebsites
//
//  Created by vectoscalar on 24/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "DataManager.h"
#import <CoreData/CoreData.h>

static DataManager *sharedDataManager = nil;

@implementation DataManager

+ (DataManager *)sharedDataManager{
    @synchronized(self) {
        if (sharedDataManager == nil) {
            sharedDataManager = [[self alloc] init];
        }
    }
    return sharedDataManager;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        @autoreleasepool {
           
            //Initialize Default Values Here
            
            
        }
    }
    return self;
}



- (BOOL)isUserLoggedIn
{
    BOOL isUserLogIn = [[NSUserDefaults standardUserDefaults] boolForKey:kUserLoginKey];
    
    return isUserLogIn;
}

- (void)loginUser
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kUserLoginKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)logOutUser
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kUserLoginKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSMutableArray *) getModelEntityData:(NSString *) entityName{
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [DataManager managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    
    NSMutableArray *entityRecords = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    return entityRecords;
}


+ (id) insertRecordToEntityName:(NSString *) entotyName{
    NSManagedObjectContext *context = [DataManager managedObjectContext];
    
    // Create a new managed object
    id newRecord = [NSEntityDescription insertNewObjectForEntityForName:entotyName inManagedObjectContext:context];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    return newRecord;
}



+ (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}



+ (void)saveUpdatedRecordToPersistanceStore{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [DataManager managedObjectContext];
    
    // Save the object to persistent store
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}



+ (void)deleteRecordFromPersistanceStore:(id) record{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [DataManager managedObjectContext];
    
    [managedObjectContext deleteObject:record];
    
    // Save the object to persistent store
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

@end
