//
//  GFChat+CoreDataProperties.h
//  
//
//  Created by Vectoscalar on 22/06/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GFChat.h"

NS_ASSUME_NONNULL_BEGIN

@interface GFChat (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *chatID;
@property (nullable, nonatomic, retain) NSString *contatct;
@property (nullable, nonatomic, retain) NSNumber *unreadMessages;
@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) GFBuyer *buyer;
@property (nullable, nonatomic, retain) NSSet<GFMessage *> *messages;

@end

@interface GFChat (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(GFMessage *)value;
- (void)removeMessagesObject:(GFMessage *)value;
- (void)addMessages:(NSSet<GFMessage *> *)values;
- (void)removeMessages:(NSSet<GFMessage *> *)values;

@end

NS_ASSUME_NONNULL_END
