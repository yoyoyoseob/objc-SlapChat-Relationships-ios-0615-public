//
//  Message.h
//  slapChat
//
//  Created by Yoseob Lee on 7/17/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Recipient;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) Recipient *recipient;

@end
