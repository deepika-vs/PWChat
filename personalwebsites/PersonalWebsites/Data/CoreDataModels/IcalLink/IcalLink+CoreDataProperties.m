//
//  IcalLink+CoreDataProperties.m
//  
//
//  Created by VectoScalar on 21/11/16.
//
//

#import "IcalLink+CoreDataProperties.h"

@implementation IcalLink (CoreDataProperties)

+ (NSFetchRequest<IcalLink *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"IcalLink"];
}

@dynamic propertyid;
@dynamic name;
@dynamic heading;
@dynamic link;
@dynamic addeddate;

@end
