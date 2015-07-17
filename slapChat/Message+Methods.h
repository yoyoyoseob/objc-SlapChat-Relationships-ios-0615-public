//
//  Message+Methods.h
//  slapChat
//
//  Created by Yoseob Lee on 7/17/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "Message.h"

@interface Message (Methods)

+ (Message *)messageWithContext:(NSManagedObjectContext *)context;

@end
