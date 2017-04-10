//
//  DatabaseManager.m
//  bro
//
//  Created by g tokman on 4/9/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

+ (FIRDatabaseReference *)newUserRef {
    return [[[FIRDatabase database] reference] child:@"users"];
}

+ (FIRDatabaseReference*)notificationRef {
    return [[[[FIRDatabase database] reference] child:@"notifications"] child:@"messages"];;
}

@end
