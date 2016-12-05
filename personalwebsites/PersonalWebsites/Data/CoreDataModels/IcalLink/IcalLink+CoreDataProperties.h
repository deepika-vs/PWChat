//
//  IcalLink+CoreDataProperties.h
//  
//
//  Created by VectoScalar on 21/11/16.
//
//

#import "IcalLink+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface IcalLink (CoreDataProperties)

+ (NSFetchRequest<IcalLink *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *propertyid;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *heading;
@property (nullable, nonatomic, copy) NSString *link;
@property (nullable, nonatomic, copy) NSString *addeddate;

@end

NS_ASSUME_NONNULL_END
