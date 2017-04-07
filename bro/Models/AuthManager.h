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

+ (void)signUpUserWithEmail:(NSString*)email password:(NSString*)password withBlock:(void(^)(FIRUser* user, NSError* error))completion;
+ (void)loginUserWithEmail:(NSString*)email password:(NSString*)password withBlock:(void(^)(FIRUser* user, NSError* error))completion;
+ (void)resetUserPassword:(NSString*)password;
+ (void)logoutUser:(void(^)(BOOL))success failure:(void(^)(NSError*))failure;

@end
