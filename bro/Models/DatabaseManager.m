//
//  DatabaseManager.m
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

+ (FIRUser*)currentUser {
    return [FIRAuth auth].currentUser;
}

+ (FIRDatabaseReference *)newUserRef {
    return [[[FIRDatabase database] reference] child:@"users"];
}

+ (FIRDatabaseReference *)newFriendRef {
    return [[[FIRDatabase database] reference] child:@"bros"];
}

+ (FIRDatabaseReference *)newFriendRequestRef {
    return [[[FIRDatabase database] reference] child:@"request"];
}

+ (FIRDatabaseReference *)notificationRef {
    return [[[[FIRDatabase database] reference] child:@"notifications"] child:@"messages"];;
}

+ (void)addNewUserToDatabase:(FIRUser *)user userName:(NSString *)username token:(NSString *)token withBlock:(DatabaseCompletion)completion {
    [[[self newUserRef] child:user.uid] setValue:@{@"uid": user.uid, @"email": user.email, @"displayName": username, @"token": token}
                             withCompletionBlock:^(NSError *_Nullable error, FIRDatabaseReference *_Nonnull ref) {
                                 completion(error, ref);
                             }];
}

+ (void)addNewFriendRequest:(BRUser*)friend withBlock:(DatabaseCompletion)completion {
    FIRDatabaseReference *newRequestRef = [[[self newFriendRequestRef] child:friend.uid] child:[self currentUser].uid];
    FIRUser *currentUser = [self currentUser];
    [newRequestRef setValue:@{@"receiver": friend.uid, @"sender":currentUser.uid} withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        completion(error, ref);
    }];
}

+ (FIRDatabaseHandle)observeNewUsersAddedHandleWithBlock:(HandleCompletion)completion {
    return [[[self newFriendRef] child:[self currentUser].uid] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *_Nonnull snapshot) {
        NSLog(@"User is ------> %@", snapshot.value);
        completion(snapshot);
    }];
}

+ (FIRDatabaseHandle)observeNewUserNotifications:(FIRUser *)user withBlock:(HandleCompletion)completion {
    return [[[self notificationRef] child:user.uid] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        completion(snapshot);
    }];
}

+ (void)addNewMessageNotificationToDatabaseWithMessageDict:(NSDictionary *)messageDict withBlock:(DatabaseCompletion)completion {
    [[[self notificationRef] childByAutoId] setValue:messageDict withCompletionBlock:^(NSError *_Nullable error, FIRDatabaseReference *_Nonnull ref) {
        completion(error, ref);
    }];
}

+ (void)queryUsersWithUsername:(NSString*)username withBlock:(HandleCompletion)completion {
    FIRDatabaseQuery *query = [[[self newUserRef] queryOrderedByChild:@"displayName"] queryEqualToValue:username];
    
    [query observeSingleEventOfType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSLog(@"Search value: %@", snapshot.value);
        completion(snapshot);
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}

@end
