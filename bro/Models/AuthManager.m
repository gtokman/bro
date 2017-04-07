//
//  AuthManager.m
//  bro
//
//  Created by g tokman on 4/7/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "AuthManager.h"

@implementation AuthManager

+ (FIRAuthStateDidChangeListenerHandle)addFirebaseAuthChangeListenerWithBlock:(void (^)(FIRAuth *, FIRUser *))completion {
    return [[FIRAuth auth]addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
        completion(auth, user);
    }];
}

+ (void)signUpUserWithEmail:(NSString *)email password:(NSString *)password withBlock:(AuthCompletion)completion {
    [[FIRAuth auth]createUserWithEmail:email password:password completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        completion(user, error);
    }];
}

+ (void)loginUserWithEmail:(NSString *)email password:(NSString *)password withBlock:(AuthCompletion)completion {
    [[FIRAuth auth]signInWithEmail:email password:password completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        completion(user, error);
    }];
}

+ (void)updateUserInfoWithDisplayName:(NSString *)displayName imageUrl:(NSURL *)url withBlock:(void (^)(NSError *))completion {
    FIRUserProfileChangeRequest *changeRequest = [[FIRAuth auth].currentUser profileChangeRequest];
    changeRequest.displayName = displayName;
    changeRequest.photoURL = url;
    [changeRequest commitChangesWithCompletion:^(NSError * _Nullable error) {
        completion(error);
    }];
}

+ (void)resetPasswordWithEmail:(NSString *)email withBlock:(void (^)(NSError *))completion {
    [[FIRAuth auth]sendPasswordResetWithEmail:email completion:^(NSError * _Nullable error) {
        completion(error);
    }];
}

+ (void)signOutUserThrowsError:(NSError *__autoreleasing *)error withBlock:(void (^)(void))completion {
    [[FIRAuth auth]signOut:error];
    completion();
}

@end
