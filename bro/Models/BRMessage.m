//
//  BRMessage.m
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "BRMessage.h"

@implementation BRMessage
- (instancetype)initWithSender:(NSString *)sender receiver:(NSString *)receiver
                          body:(NSString *)body timestamp:(NSString *)time {
    self = [super init];
    if (self) {
        self.sender = sender;
        self.receiver = receiver;
        self.body = body;
        self.timeStamp = time;
    }
    return self;
}

- (instancetype)initWithMessageDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.sender = dictionary[@"sender"];
        self.receiver = dictionary[@"receiver"];
        self.body = dictionary[@"body"];
        self.timeStamp = dictionary[@"timestamp"];
    }
    return self;
}

- (NSDictionary *)messageToJsonDictionary {
    return @{
             @"sender":self.sender,
             @"receiver":self.receiver,
             @"body":self.body,
             @"time":self.timeStamp,
             @"icon":@"https://avatars2.githubusercontent.com/u/24276710?v=3"
             };
}
@end
