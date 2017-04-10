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


@interface DatabaseManager : NSObject

typedef void(^DatabaseCompletion)(NSError* error, FIRDatabaseReference* ref);
typedef void(^HandleCompletion)(FIRDataSnapshot* snapshot);
+ (FIRDatabaseReference*)newUserRef;
+ (void)addNewUserToDatabase:(FIRUser*)user userName:(NSString*)username withBlock:(DatabaseCompletion)completion;
+ (FIRDatabaseHandle)observeNewUsersAddedHandleWithBlock:(HandleCompletion)completion;
@end
