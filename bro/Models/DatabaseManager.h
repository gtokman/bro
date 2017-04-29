//
//  DatabaseManager.h
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import "BRUser.h"
@import Firebase;

@interface DatabaseManager : NSObject

typedef void(^DatabaseCompletion)(NSError* error, FIRDatabaseReference* ref);
typedef void(^HandleCompletion)(FIRDataSnapshot* snapshot);

+ (FIRDatabaseReference*)newUserRef;
+ (FIRDatabaseReference *)notificationRef;
+ (void)getUserFromDatabaseWithUID:(NSString*)uid withBlock:(HandleCompletion)completion;
+ (void)addNewUserToDatabase:(FIRUser*)user userName:(NSString*)username token:(NSString*)token withBlock:(DatabaseCompletion)completion;
+ (void)addNewFriend:(BRUser *)friend withSelfBlock:(DatabaseCompletion)selfCompletion withFriendBlock:(DatabaseCompletion)friendCompletion;
+ (void)addNewFriendRequest:(BRUser*)user withBlock:(DatabaseCompletion)completion;
+ (FIRDatabaseHandle)observeNewUsersAddedHandleWithBlock:(HandleCompletion)completion;
+ (FIRDatabaseHandle)observeNewUserNotificationsWithBlock:(HandleCompletion)completion;
+ (FIRDatabaseHandle)observeNewMessageWithBlock:(HandleCompletion)completion;
+ (void)removeNotificationRefWithUser:(BRUser *)user;
+ (void)addNewBroNotificationToFriend:(BRUser *)friend withBlock:(DatabaseCompletion)completion;
+ (void)queryUsersWithUsername:(NSString*)username withBlock:(HandleCompletion)completion;
+ (void)queryNewBroMessagesWithBlock:(HandleCompletion)completion;
@end
