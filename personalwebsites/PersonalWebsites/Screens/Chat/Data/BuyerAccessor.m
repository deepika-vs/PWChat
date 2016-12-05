//
//  BuyerAccessor.m
//  GoFro
//
//  Created by VectoScalar on 10/06/16.
//  Copyright © 2016 BonaVita. All rights reserved.
//

#import "BuyerAccessor.h"
//#import "RequestExecutor.h"

@implementation BuyerAccessor



+ (NSString *)getBuyerId
{
//    
//    NSArray *buyerArray = [RequestExecutor executeRequestForEntity:@"GFBuyer" predicate:nil andDescriptor:nil];
//    
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    GFBuyer *buyer;
//    
//    
//    if(buyerArray && [buyerArray count]>0)
//    {
//        buyer = [buyerArray objectAtIndex:0];
//    }
//    else
//    {
//      buyer = [NSEntityDescription insertNewObjectForEntityForName:@"GFBuyer" inManagedObjectContext:appDelegate.managedObjectContext];
//        buyer.buyerId = @"GF12";
//        buyer.buyerName = @"Rahul";
//
//        [RequestExecutor saveContext];
//    }
//    
    return nil;
  
}


+ (void)chatReceived
{
    
    NSString *buyerId = [BuyerAccessor getBuyerId];
    
    
    NSPredicate *predicate
    = [NSPredicate predicateWithFormat:@"buyerId = %@",buyerId];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Document"];
    fetchRequest.predicate = predicate;
    
    
    
//    NSArray *array = [RequestExecutor executeRequestForEntity:@"Document" predicate:predicate andDescriptor:nil];
//    
//    
//    NSArray *array = [RequestExecutor executeRequestForEntity:@"GFBuyer" predicate:nil andDescriptor:nil];
//    
//    for(GFBuyer *cht in array)
//    {
//        DebugLog(@"%@----",cht.buyerName);
//        
//        
//        DebugLog(@"------");
//        
//    }
//    
}

@end
