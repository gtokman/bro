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

@interface DatabaseManager : NSObject

typedef void(^DatabaseCompletion)(NSError* error, FIRDatabaseReference* ref);
typedef void(^HandleCompletion)(FIRDataSnapshot* snapshot);
+ (FIRDatabaseReference*)newUserRef;
+ (FIRDatabaseReference *)notificationRef;
+ (void)addNewUserToDatabase:(FIRUser*)user userName:(NSString*)username token:(NSString*)token withBlock:(DatabaseCompletion)completion;
+ (void)addNewFriend:(BRUser*)user withBlock:(DatabaseCompletion)completion;
+ (FIRDatabaseHandle)observeNewUsersAddedHandleWithBlock:(HandleCompletion)completion;
+ (FIRDatabaseHandle)observeNewUserNotifications:(FIRUser *)user withBlock:(HandleCompletion)completion;
+ (void)addNewMessageNotificationToDatabaseWithMessageDict:(NSDictionary*)messageDict withBlock:(DatabaseCompletion)completion;
+ (void)queryUsersWithUsername:(NSString*)username withBlock:(HandleCompletion)completion;
@end
