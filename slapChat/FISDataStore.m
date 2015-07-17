//
//  FISDataStore.m
//  playingWithCoreData
//
//  Created by Joe Burgess on 6/27/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISDataStore.h"

@implementation FISDataStore
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark - Singleton

+ (instancetype)sharedDataStore {
    static FISDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[FISDataStore alloc] init];
    });

    return _sharedDataStore;
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"slapChat.sqlite"];
    
    NSError *error = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"slapChat" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Fetch/Save

- (void)fetchData
{
    NSFetchRequest *recipientsRequest = [NSFetchRequest fetchRequestWithEntityName:@"Recipient"];

//    NSSortDescriptor *createdAtSorter = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:YES];
//    messagesRequest.sortDescriptors = @[createdAtSorter];

    self.recipients = [self.managedObjectContext executeFetchRequest:recipientsRequest error:nil];

    if ([self.recipients count]==0) {
        [self generateTestData];
    }
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Test data

- (void)generateTestData
{
    Recipient *personOne = [NSEntityDescription insertNewObjectForEntityForName:@"Recipient" inManagedObjectContext:self.managedObjectContext];
    personOne.name = @"Person One";
    personOne.email = @"bogus@gmail.com";
    personOne.phoneNumber = @"1234567890";
    
    Message *messageOne = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:self.managedObjectContext];
    
    messageOne.content = @"Message 1";
    messageOne.createdAt = [NSDate date];
    
    [personOne addMessagesObject:messageOne];
    
    
    
    Recipient *personTwo = [NSEntityDescription insertNewObjectForEntityForName:@"Recipient" inManagedObjectContext:self.managedObjectContext];
    personTwo.name = @"Person Two";
    personTwo.email  = @"false@gmail.com";
    personTwo.phoneNumber = @"0987654321";
    
    Message *messageTwo = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:self.managedObjectContext];
    messageTwo.content = @"Message 2";
    messageTwo.createdAt = [NSDate date];
    
    Message *messageFour = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:self.managedObjectContext];
    messageFour.content = @"Message 4";
    messageFour.createdAt = [NSDate date];
    
    [personTwo addMessagesObject:messageTwo];
    [personTwo addMessagesObject:messageFour];
    
    
    
    Recipient *personThree = [NSEntityDescription insertNewObjectForEntityForName:@"Recipient" inManagedObjectContext:self.managedObjectContext];
    personThree.name = @"Person Three";
    personThree.email = @"real@gmail.com";
    personThree.phoneNumber = @"8452958491";
    
    Message *messageThree = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:self.managedObjectContext];
    
    messageThree.content = @"Message 3";
    messageThree.createdAt = [NSDate date];
    
    [personThree addMessagesObject:messageThree];
    
    [self saveContext];
    [self fetchData];
}

#pragma mark - Helpers

- (Message *)createMessage
{
    return [Message messageWithContext:self.managedObjectContext];
}
@end
