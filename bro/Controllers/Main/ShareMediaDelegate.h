//
//  ShareMediaDelegate.h
//  bro
//
//  Created by g tokman on 4/13/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRUser.h"

@class BRUser;
@protocol ShareMediaDelegate <NSObject>
- (void)didSelectUser:(BRUser*)user;
@end
