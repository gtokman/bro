//
//  DatabaseManager.h
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

@interface DatabaseManager : NSObject

typedef void(^DatabaseCompletion)(NSError* error, FIRDatabaseReference* ref);

+ (FIRDatabaseReference*)newUserRef;

@end
