//
//  DataManager.h
//  PersonalWebsites
//
//  Created by vectoscalar on 24/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataManager : NSObject


+ (DataManager *)sharedDataManager;

- (BOOL)isUserLoggedIn;
- (void)logOutUser;
- (void)loginUser;

+ (NSMutableArray *)getModelEntityData:(NSString *) entityName;
+ (id)insertRecordToEntityName:(NSString *) entotyName;
+ (void)saveUpdatedRecordToPersistanceStore;
+ (void)deleteRecordFromPersistanceStore:(id) record;
@end
