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

+ (void)signUpUserWithEmail:(NSString*)email password:(NSString*)password error:(void(^)(NSError*))failure;
+ (void)loginUserWithEmail:(NSString*)email password:(NSString*)password error:(void(^)(NSError*))failure;
+ (void)resetUserPassword:(NSString*)password;
+ (void)logoutUser:(void(^)(BOOL))success failure:(void(^)(NSError*))failure;

@end
