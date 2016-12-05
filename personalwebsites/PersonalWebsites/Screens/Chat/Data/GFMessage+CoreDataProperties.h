//
//  GFMessage+CoreDataProperties.h
//  
//
//  Created by Vectoscalar on 22/06/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GFMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface GFMessage (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSString *messageId;
@property (nullable, nonatomic, retain) NSNumber *messageStatus;
@property (nullable, nonatomic, retain) NSString *messageText;
@property (nullable, nonatomic, retain) NSNumber *messageTime;
@property (nullable, nonatomic, retain) NSString *messageType;
@property (nullable, nonatomic, retain) NSString *receiver;
@property (nullable, nonatomic, retain) NSString *sender;
@property (nullable, nonatomic, retain) NSNumber *userType;
@property (nullable, nonatomic, retain) GFChat *chat;

@end

NS_ASSUME_NONNULL_END
