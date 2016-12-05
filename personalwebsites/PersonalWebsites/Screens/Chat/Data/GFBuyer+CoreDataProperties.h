//
//  GFBuyer+CoreDataProperties.h
//  
//
//  Created by Vectoscalar on 22/06/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GFBuyer.h"

NS_ASSUME_NONNULL_BEGIN

@interface GFBuyer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *buyerId;
@property (nullable, nonatomic, retain) NSString *buyerName;
@property (nullable, nonatomic, retain) NSSet<GFChat *> *chats;

@end

@interface GFBuyer (CoreDataGeneratedAccessors)

- (void)addChatsObject:(GFChat *)value;
- (void)removeChatsObject:(GFChat *)value;
- (void)addChats:(NSSet<GFChat *> *)values;
- (void)removeChats:(NSSet<GFChat *> *)values;

@end

NS_ASSUME_NONNULL_END
