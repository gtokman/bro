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
    }
    return self;
}

- (NSDictionary *)userToJsonDictionary {
    return @{
            @"email": self.email,
            @"displayName": self.displayName,
            @"uid": self.uid,
            @"token": self.token
    };
}
}

@end
