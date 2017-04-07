//
//  AuthManager.m
//  bro
//
//  Created by g tokman on 4/7/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "AuthManager.h"

@implementation AuthManager

+ (void)signUpUserWithEmail:(NSString *)email password:(NSString *)password withBlock:(void (^)(FIRUser *, NSError *))completion {
    [[FIRAuth auth]createUserWithEmail:email password:password completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        completion(user, error);
    }];
}

+ (void)loginUserWithEmail:(NSString *)email password:(NSString *)password withBlock:(void (^)(FIRUser *, NSError *))completion {
    [[FIRAuth auth]signInWithEmail:email password:password completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        completion(user, error);
    }];
}

+ (void)logoutUser:(void (^)(BOOL))success failure:(void (^)(NSError *))failure {
    
}

+ (void)resetUserPassword:(NSString *)password {
    
}

@end
