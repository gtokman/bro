//
//  DatabaseManager.m
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

+ (FIRDatabaseReference *)newUserRef {
    return [[[FIRDatabase database] reference] child:@"users"];
}

+ (FIRDatabaseReference *)notificationRef {
    return [[[[FIRDatabase database] reference] child:@"notifications"] child:@"messages"];;
}

+ (void)addNewUserToDatabase:(FIRUser *)user userName:(NSString*)username withBlock:(DatabaseCompletion)completion {
    [[[self newUserRef] child:user.uid] setValue:@{@"uid":user.uid, @"email":user.email, @"displayName":username} withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        completion(error, ref);
    }];
}

+ (FIRDatabaseHandle)observeNewUsersAddedHandleWithBlock:(HandleCompletion)completion {
    return [[self newUserRef] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completion(snapshot);
    }];
}

+ (void)addNewMessageNotificationToDatabaseWithMessageDict:(NSDictionary*)messageDict withBlock:(DatabaseCompletion)completion {
    [[[self notificationRef] childByAutoId] setValue:messageDict withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        completion(error, ref);
    }];
}

@end
