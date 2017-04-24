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
    return [[[FIRDatabase database] reference] child:@"friends"];
}

+ (FIRDatabaseReference *)newFriendRequestRef {
    return [[[FIRDatabase database] reference] child:@"request"];
}

+ (FIRDatabaseReference *)notificationRef {
    return [[[FIRDatabase database] reference] child:@"notifications"];
}

+ (FIRDatabaseReference *)broNotificationRef {
    return [[[FIRDatabase database] reference] child:@"bro-notifications"];
}

+ (void)addNewUserToDatabase:(FIRUser *)user userName:(NSString *)username token:(NSString *)token withBlock:(DatabaseCompletion)completion {
    [[[self newUserRef] child:user.uid]
     setValue:@{@"uid": user.uid, @"email": user.email, @"displayName": username, @"token": token}
     withCompletionBlock:^(NSError *_Nullable error, FIRDatabaseReference *_Nonnull ref) {
         completion(error, ref);
     }];
}

+ (void)getUserFromDatabaseWithUID:(NSString*)uid withBlock:(HandleCompletion)completion {
    [[[self newUserRef] child:uid]
     observeSingleEventOfType:FIRDataEventTypeValue
     withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
         completion(snapshot);
    }];
}

+ (void)addNewFriendRequest:(BRUser*)friend withBlock:(DatabaseCompletion)completion {
    FIRDatabaseReference *newRequestRef = [[[self newFriendRequestRef] child:friend.uid] child:[self currentUser].uid];
    FIRUser *currentUser = [self currentUser];
    [newRequestRef setValue:@{@"receiver": friend.uid, @"sender":currentUser.uid}
        withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        completion(error, ref);
    }];
}

+ (void)addNewBroNotificationToFriend:(BRUser *)friend withBlock:(DatabaseCompletion)completion {
    FIRUser *currentUser = [self currentUser];
    [[[[self broNotificationRef] child:friend.uid] childByAutoId] setValue:@{@"receiver": friend.uid, @"sender":currentUser.uid, @"title": @"Bro"} withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        completion(error, ref);
    }];
}

+ (void)addNewFriend:(BRUser *)friend withSelfBlock:(DatabaseCompletion)selfCompletion withFriendBlock:(DatabaseCompletion)friendCompletion {
    
    [self getUserFromDatabaseWithUID:[self currentUser].uid withBlock:^(FIRDataSnapshot *snapshot) {
        BRUser *currentUser = [[BRUser alloc] initWithJsonDictionary:snapshot.value];
        // ref/friends/{currentUserUid}/{friendUId}
        friend.isFriend = YES;
        [[[[self newFriendRef] child:currentUser.uid] child:friend.uid]
         setValue:friend.userToJsonDictionary
         withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
             selfCompletion(error, ref);
         }];
        
        // ref/friends/{friendUid}/{currentUserUid}
        currentUser.isFriend = YES;
        [[[[self newFriendRef] child:friend.uid] child:currentUser.uid]
         setValue: [currentUser userToJsonDictionary]
         withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
             friendCompletion(error, ref);
         }];
    }];
}

+ (FIRDatabaseHandle)observeNewUsersAddedHandleWithBlock:(HandleCompletion)completion {
    return [[[self newFriendRef] child:[self currentUser].uid] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *_Nonnull snapshot) {
        NSLog(@"User is ------> %@", snapshot.value);
        completion(snapshot);
    }];
}

+ (FIRDatabaseHandle)observeNewUserNotificationsWithBlock:(HandleCompletion)completion {
    return [[[self notificationRef] child:[self currentUser].uid] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        completion(snapshot);
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
