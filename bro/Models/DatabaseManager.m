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

+ (FIRDatabaseReference *)newFriendRef {
    return [[[FIRDatabase database] reference] child:@"bros"];
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

+ (void)addNewFriend:(BRUser*)friend withBlock:(DatabaseCompletion)completion {
    FIRDatabaseReference *newFriendRef = [[[self newFriendRef]
                                            child:[FIRAuth auth].currentUser.uid]
                                           child:friend.uid];
    [newFriendRef setValue:friend.userToJsonDictionary
       withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        completion(error, ref);
    }];
    
}

+ (FIRDatabaseHandle)observeNewUsersAddedHandleWithBlock:(HandleCompletion)completion {
    return [[self newUserRef] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *_Nonnull snapshot) {
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
