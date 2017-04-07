//
//  AuthManager.h
//  bro
//
//  Created by g tokman on 4/7/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FirebaseAuth/FirebaseAuth.h>

@interface AuthManager : NSObject

typedef void(^AuthCompletion)(FIRUser* user, NSError* error);

+ (void)signUpUserWithEmail:(NSString*)email password:(NSString*)password withBlock:(AuthCompletion)completion;
+ (void)loginUserWithEmail:(NSString*)email password:(NSString*)password withBlock:(AuthCompletion)completion;
+ (void)updateUserInfoWithDisplayName:(NSString*)displayName imageUrl:(NSURL*)url withBlock:(void(^)(NSError*))completion;
+ (void)resetPasswordWithEmail:(NSString*)email withBlock:(void(^)(NSError*))completion;
+ (void)signOutUserThrowsError:(NSError**)error withBlock:(void(^)(void))completion;
+ (FIRAuthStateDidChangeListenerHandle)addFirebaseAuthChangeListenerWithBlock:(void(^)(FIRAuth *auth, FIRUser* user))completion;

@end
