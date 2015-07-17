//
//  Recipient.h
//  slapChat
//
//  Created by Yoseob Lee on 7/17/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Message;

@interface Recipient : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * twitterHandle;
@property (nonatomic, retain) NSSet *messages;
@end

@interface Recipient (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(Message *)value;
- (void)removeMessagesObject:(Message *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

@end
