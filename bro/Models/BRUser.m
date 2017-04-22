//
//  BRUser.m
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "BRUser.h"

@implementation BRUser

- (instancetype)initWithJsonDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.email = dictionary[@"email"];
        self.displayName = dictionary[@"displayName"];
        self.uid = dictionary[@"uid"];
        self.token = dictionary[@"token"];
        NSLog(@"isAccept %@ and isFriend %@", dictionary[@"isBlocked"], dictionary[@"isFriend"]);
        self.isBlocked = ((NSNumber*)dictionary[@"isBlocked"]).boolValue;
        self.isFriend = ((NSNumber*)dictionary[@"isFriend"]).boolValue;
    }
    return self;
}

- (NSDictionary *)userToJsonDictionary {
    return @{
            @"email": self.email,
            @"displayName": self.displayName,
            @"uid": self.uid,
            @"token": self.token,
            @"isBlocked": @(self.isBlocked),
            @"isFriend": @(self.isFriend)
    };
}

@end
