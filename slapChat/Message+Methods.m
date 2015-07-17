//
//  Message+Methods.m
//  slapChat
//
//  Created by Yoseob Lee on 7/17/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "Message+Methods.h"

@implementation Message (Methods)

+(Message *) messageWithContext:(NSManagedObjectContext *)context
{
    Message *newMessage = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:context];
    return newMessage;
}

@end
