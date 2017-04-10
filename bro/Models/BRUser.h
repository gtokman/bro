//
//  BRUser.h
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRUser : NSObject
@property NSString *email;
@property NSString *displayName;
@property NSString *uid;

- (instancetype)initWithJsonDictionary:(NSDictionary*)dictionary;
- (NSDictionary*)userToJsonDictionary;
@end
