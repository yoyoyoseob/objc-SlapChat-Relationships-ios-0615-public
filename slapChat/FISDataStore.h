//
//  FISDataStore.h
//  playingWithCoreData
//
//  Created by Joe Burgess on 6/27/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message+Methods.h"
#import "Recipient.h"

@interface FISDataStore : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *recipients;

+ (instancetype) sharedDataStore;

- (void) saveContext;
- (void) generateTestData;
- (void) fetchData;
- (Message *) createMessage;
@end
