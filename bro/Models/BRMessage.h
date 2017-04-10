//
//  BRMessage.h
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface BRMessage : NSObject
@property NSString *sender;
@property NSString *receiver;
@property NSString *body;
@property NSString *timeStamp;

- (instancetype)initWithSender:(NSString*)sender receiver:(NSString*)receiver
                          body:(NSString*)body timestamp:(NSString*)time;
- (NSDictionary*)messageToJsonDictionary;

@end
NS_ASSUME_NONNULL_END
